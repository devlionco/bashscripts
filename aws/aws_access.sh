#!/usr/bin/env bash
# ec2_ssm_menu_name_and_state.sh

set -euo pipefail

###############################################################################
# 0. Parameters and defaults                                                  #
###############################################################################
PROFILE="${1:-cyber}"          # AWS CLI profile (1st CLI arg or “cyber”)
TAG_KEY="project"              # Tag we filter on
TAG_VAL="cyber-moodle"         # …and its value
NAME_TAG_KEY="Name"            # *** tag whose value is printed in option menu ***
###############################################################################
# 1. Query AWS once: InstanceId • State • Name tag value                      #
###############################################################################
echo -e "\nFetching EC2 instances with tag ${TAG_KEY}=${TAG_VAL} …"

# Use --query to pull exactly what we need and emit tab‑separated fields
mapfile -t rows < <(
  aws ec2 describe-instances \
    --profile "$PROFILE" \
    --filters "Name=tag:${TAG_KEY},Values=${TAG_VAL}" \
    --query  "
                  Reservations[].Instances[].{
                    Id: InstanceId,
                    St: State.Name,
                    Nm: Tags[?Key==\`${NAME_TAG_KEY}\`] | [0].Value
                  }" \
    --output text |
  awk -v OFS=$'\t' '{print $1,$2,$3}'
)

if ((${#rows[@]}==0)); then
  echo "❌  No instances matched. Exiting." >&2
  exit 1
fi

###############################################################################
# 2. Build the interactive menu                                               #
###############################################################################
declare -a choices ids
for line in "${rows[@]}"; do
  IFS=$'\t' read -r id  name_val  state <<<"$line"
  name_val=${name_val:--}   # “-” if tag is missing
  choices+=("$id  ($state)  [${NAME_TAG_KEY}=${name_val}]")
  ids+=("$id")
done

###############################################################################
# 3. Present menu and capture selection                                       #
###############################################################################
PS3=$'\nChoose an instance to connect: '
select item in "${choices[@]}"; do
  if [[ -n $item ]]; then
    idx=$((REPLY-1))
    chosen_id=${ids[$idx]}
    echo -e "\nOpening SSM session to $chosen_id …"
    break
  else
    echo "❌  Invalid selection."
  fi
done

###############################################################################
# 4. Start the Session Manager session                                        #
###############################################################################
aws ssm start-session --profile "$PROFILE" --target "$chosen_id"
