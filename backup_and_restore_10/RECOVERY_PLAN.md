### Database Recovery plan

* Notify all affected stakeholders
* Get latest backup from Amazon S3 bucket
* Load the backup into a new database
* Ensure database backup is loaded properly and works fine
* Cut off from the old database and redirect connection to the new database
* Notify all affected stakeholders of progress
