export async function handler(event) {
  // NOTE: In a production environment, a more robust authentication should be implemented,
  // such as JWT validation or IAM-based access control. For the sake of this Terraform demo,
  // I'm using a quick sample authorizer that simply checks if the token equals "allow".
  
  // Retrieve the token from the headers (supports both "Authorization" and "authorization")
  const token = event.headers?.Authorization || event.headers?.authorization;
  
  // For this demo, simply check if the token equals "allow"
  if (token === "allow") {
    return { isAuthorized: true };
  } else {
    return { isAuthorized: false };
  }
}
