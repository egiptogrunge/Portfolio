The flows 1 and 2 were created to automate the process of registering clients in a gym.

The flow 1 is for general registration.

Summary of this automation:

- The flow is triggered by a webhook subscription for one dataverse table.
- The flow checks the value of the "fitness class" field in the trigger output.
- If the value is "Cycling", it starts an approval process for the "Cycling" activity.
- If the approval outcome is "Approve", it updates the "Status" field in the table to "Approved" and sends an email with an image to the subscriber.
- If the outcome is not "Approve", it updates the "Status" field to "Not approved" and sends a rejection email to the subscriber.
- Similar approval and email processes are performed for the "Musculação" and "Yoga" activities based on their respective values.
- If the "fitness class" value does not match any of the specified cases, an email is sent to notify about the failure.
- Finally, the flow updates the dataverser table.


The flow 2 is specifically for clients who enrolled in a promotional campaign.

Summary of this automation:

- The flow is triggered by a webhook subscription for the "contact" entity.
- If the age of the contact is less than 18, an email is sent to the contact's guardian requesting approval.
- An approval process is initiated and awaits the guardian's response.
- If both the gym administration and the guardian approve, an email is sent to the contact confirming their registration.
- If not, an email is sent to the contact informing them that their registration was not accepted.
- If the contact is 18 or older, an approval process is initiated without involving a guardian.
- If approval is granted, an email is sent to the contact confirming their registration.
- If approval is not granted, an email is sent to the contact informing them that their registration was not accepted.
- The contact record field, in a Dataverse table, is updated with the approval status.
