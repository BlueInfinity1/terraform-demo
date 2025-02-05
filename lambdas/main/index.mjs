import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, PutCommand } from "@aws-sdk/lib-dynamodb";

// Create a DynamoDB client and a document client
const client = new DynamoDBClient({ region: process.env.AWS_REGION });
const documentClient = DynamoDBDocumentClient.from(client);

export async function handler(event) {
  try {
    const randomNumber = Math.floor(Math.random() * 1000).toString();
    const item = {
      id: new Date().toISOString(),
      value: randomNumber,
    };

    // Write item to the DynamoDB table (table name provided via env variable)
    await documentClient.send(new PutCommand({
      TableName: process.env.DYNAMODB_TABLE,
      Item: item,
    }));

    return {
      statusCode: 200,
      body: JSON.stringify({ message: "Number stored!", data: item }),
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message }),
    };
  }
}
