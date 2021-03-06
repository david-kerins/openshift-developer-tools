#!/bin/bash

OCTOOLSBIN=$(dirname $0)

usage() { #Usage function
  cat <<-EOF
  Delete and recreate with defaults the routes in an environment.

  Usage:
    ${0##*/} [options]
EOF
}

if [ -f ${OCTOOLSBIN}/settings.sh ]; then
  . ${OCTOOLSBIN}/settings.sh
fi

if [ -f ${OCTOOLSBIN}/ocFunctions.inc ]; then
  . ${OCTOOLSBIN}/ocFunctions.inc
fi

# ===================================================================================
# Fix routes
projectName=$(getProjectName)
echo -e "Update routes to default in ${projectName} ..."

for route in ${routes}; do
  oc -n ${projectName} delete route ${route}
  oc -n ${projectName} create route edge --service=${route}
  sleep 3 # Allow the creation of the route to complete
done
