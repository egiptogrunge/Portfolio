# Examples of flows created on Power Automate

## The flows 1 and 2 were created to automate the process of registering clients in a gym.

## The flow 1 is for general registration.
![Captura de ecrã 2024-04-21 234120](https://github.com/egiptogrunge/Portfolio/assets/161729526/bf75acc4-8dc0-4070-b543-b90e02b8b8c9)

Summary of this automation:

- The flow is triggered by a webhook subscription for one dataverse table.
- The flow checks the value of the "fitness class" field in the trigger output.
- If the value is "Cycling", it starts an approval process for the "Cycling" activity.
- If the approval outcome is "Approve", it updates the "Status" field in the table to "Approved" and sends an email with an image to the subscriber.
- If the outcome is not "Approve", it updates the "Status" field to "Not approved" and sends a rejection email to the subscriber.
- Similar approval and email processes are performed for the "Musculação" and "Yoga" activities based on their respective values.
- If the "fitness class" value does not match any of the specified cases, an email is sent to notify about the failure.
- Finally, the flow updates the dataverser table.

Details:

![Captura de ecrã 2024-04-21 234206](https://github.com/egiptogrunge/Portfolio/assets/161729526/0eeec21e-8c64-4589-91fd-569128ac7ede)

![Captura de ecrã 2024-04-21 234230](https://github.com/egiptogrunge/Portfolio/assets/161729526/470f7364-6232-4503-bd8e-5a3d39ffec5c)

![Captura de ecrã 2024-04-21 234246](https://github.com/egiptogrunge/Portfolio/assets/161729526/97880faf-e9b9-4d35-b536-e7087ee70054)

## The flow 2 is specifically for clients who enrolled in a promotional campaign.
![Captura de ecrã 2024-04-21 234529](https://github.com/egiptogrunge/Portfolio/assets/161729526/5d606c0c-5964-43da-b93a-bf52669b0f47)

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

Details:

![Captura de ecrã 2024-04-21 234657](https://github.com/egiptogrunge/Portfolio/assets/161729526/da6aaff8-7789-4e51-b163-77215e9b37f6)

![Captura de ecrã 2024-04-21 234723](https://github.com/egiptogrunge/Portfolio/assets/161729526/ebc90361-68be-4958-b173-f3def2b1dd16)

![Captura de ecrã 2024-04-21 234801](https://github.com/egiptogrunge/Portfolio/assets/161729526/35f78047-ac81-466c-a16e-17745e046815)

![Captura de ecrã 2024-04-21 234814](https://github.com/egiptogrunge/Portfolio/assets/161729526/caaedc7b-b059-4acc-af12-d7f44efa9c90)
