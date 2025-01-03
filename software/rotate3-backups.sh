#!/bin/ksh
#
# $Id: rotate3-backups.sh,v 0.25 2024/11/30 02:20:53 kc4zvw Exp kc4zvw $

MAILTO=kc4zvw@localhost
MAILCC=`logname`
MAILBCC=kc4zvw@earthlink.net

LOGFILE=~/.backup_logfile.$$

WHICH=/usr/bin/which
CAT=$(${WHICH} cat)
#CP=$(${WHICH} cp)
FIND=$(${WHICH} find)
LS=$(${WHICH} ls)
MAILER=$(${WHICH} mailx)
RM=$(${WHICH} rm)
TEE=$(${WHICH} tee)
TZ=EST5EDT

SUBJECT="Cleaning out archived and older backup files"
HOSTNAME=`hostname`
BACKUPDIR=/mnt/blockstorage/backups
TIMECODE=+33			# about 5 weeks

# Create a message for status email

${CAT} <<EOT > $LOGFILE
This is $HOSTNAME and we are cleaning out backups that are older
than 5 weeks ...

EOT

${FIND} "${BACKUPDIR}/" -mtime ${TIMECODE} -type f -exec "${LS}" -a {} \; | ${TEE} -a "$LOGFILE"
${FIND} "${BACKUPDIR}/" -mtime ${TIMECODE} -type f -exec "${RM}" -f {} \;

# Mail out status of job and log file

${MAILER} -s "$SUBJECT" "$MAILTO" "$MAILCC" < "$LOGFILE"

# Cleanup the temporary log file

${RM} $LOGFILE

# End of script
