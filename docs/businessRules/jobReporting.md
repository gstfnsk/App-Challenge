# Business Rule: Job Reporting

**Users can report suspicious job postings** via the job detail page. Each report will be added to a list of reported jobs, stored in CloudKit. **A reason must be provided** by the user and saved alongside the report in the database.

After submission, **platform administrators will review the report**. If action is required, they may remove the job posting or take other appropriate measures. **All administrative actions**, whether action was taken or deemed unnecessary, must be logged accordingly.

In future app versions, users will be able to view the status and history of their submitted reports, including whether the report was reviewed and what action, if any, was taken.