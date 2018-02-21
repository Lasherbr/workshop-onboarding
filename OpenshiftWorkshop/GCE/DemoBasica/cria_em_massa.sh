#!/bin/bash
for x in `cat mass.txt`; do ansible-playbook create_student_instance-mass.yml -e "user=$x"; done
