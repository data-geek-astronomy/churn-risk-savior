# Setup Guide

## Quick Start (2 minutes)

The workflow is already live. Just test it:

```bash
curl -X POST https://aravind5.app.n8n.cloud/webhook/churn-risk \
  -H "Content-Type: application/json" \
  -d '{"message": "I want to cancel my subscription."}'
```

## Full Setup (Self-Hosted n8n)

### Prerequisites

- n8n (self-hosted or cloud)
- OpenAI API key
- Slack workspace (for notifications)
- Jira Cloud account (for ticketing)
- Google account (for Calendar API)

### Step 1: Export the Workflow

1. Go to: `https://aravind5.app.n8n.cloud/workflow/AT9pqEZymWW95rTr`
2. Click **Export** (three dots menu)
3. Download the JSON file

### Step 2: Import into Your n8n

1. In your n8n instance, click **Import workflow**
2. Select the exported JSON file
3. Click **Import**

### Step 3: Configure Credentials

#### OpenAI API

1. Open the workflow
2. Click the **GPT-4o Mini** node
3. Under credentials dropdown, click **+ Create new**
4. Select **OpenAI API**
5. Paste your OpenAI API key from https://platform.openai.com/api-keys
6. Click **Save**

#### Slack

1. Click the **Slack Alert - HIGH** node
2. Under credentials, click **+ Create new**
3. Select **Slack API**
4. Connect your Slack workspace
5. Grant permission to post messages

#### Jira

1. Click the **Jira Ticket - HIGH** node
2. Under credentials, click **+ Create new**
3. Select **Jira Cloud API**
4. Enter your Jira domain and API token
5. Generate token at: https://id.atlassian.com/manage-profile/security/api-tokens

#### Google Calendar

1. Click the **Calendar Invite - HIGH** node
2. Under credentials, click **+ Create new**
3. Select **Google Calendar OAuth2**
4. Connect your Google account
5. Grant Calendar access

### Step 4: Configure Workflow Nodes

#### Jira Node

1. Click **Jira Ticket - HIGH** node
2. In **Project**, select your Jira project from dropdown
3. In **Issue Type**, select "Bug" or "Task"
4. Leave summary as-is (uses AI-generated text)

#### Slack Node

1. Click **Slack Alert - HIGH** node
2. In **Channel**, type or select `#churn-risk-alerts`
3. (The channel will be auto-created if it doesn't exist)

#### Google Calendar Node

1. Click **Calendar Invite - HIGH** node
2. In **Attendees**, replace with your email
3. Other fields are pre-configured

### Step 5: Activate

1. Click the **Activate** toggle at the top right
2. The workflow is now live!

### Step 6: Get Webhook URL

1. Click the **Receive Support Ticket** trigger node
2. Copy the **Production URL**
3. Use this URL for your integrations

### Step 7: Test

```bash
curl -X POST <YOUR_WEBHOOK_URL> \
  -H "Content-Type: application/json" \
  -d '{"message": "I want to cancel."}'
```

## Local Testing (Python)

```bash
# Install dependencies
pip install -r requirements.txt

# Run the Streamlit app
streamlit run app.py
```

Then open `http://localhost:8501` and test via the web UI.

## Docker Setup

```dockerfile
FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY app.py .

CMD ["streamlit", "run", "app.py"]
```

Build and run:

```bash
docker build -t churn-risk-savior .
docker run -p 8501:8501 churn-risk-savior
```

## Environment Variables

Create a `.env` file (if running locally):

```bash
OPENAI_API_KEY=sk-xxx
SLACK_BOT_TOKEN=xoxb-xxx
JIRA_API_TOKEN=xxx
GOOGLE_CALENDAR_TOKEN=xxx
```

## Troubleshooting

### "Webhook not registered"
- Make sure the workflow is **Activated** (toggle at top right)
- Wait 10 seconds after activating

### "Credential not configured"
- Each node needs credentials set up
- Click the node and configure via the credentials dropdown

### "Missing or invalid required parameters"
- Jira: Did you select Project and Issue Type?
- Slack: Did you select a channel?
- Google Calendar: Did you add your email as attendee?

### "API Error: Invalid OpenAI key"
- Check your API key at https://platform.openai.com/api-keys
- Make sure it's from your account (not a shared account)
- Ensure the key has sufficient credits

### Slack channel doesn't exist
- The channel will be created automatically
- Or manually create `#churn-risk-alerts` in Slack first

### Jira ticket not created
- Verify you're using Jira **Cloud** (not Server)
- Check the API token has "write" permissions
- Make sure the Project exists and you have access

## Production Deployment

### n8n Cloud

1. Already deployed! Just use: `https://aravind5.app.n8n.cloud/webhook/churn-risk`
2. No additional setup needed

### Self-Hosted on AWS EC2

```bash
# SSH into your server
ssh -i key.pem ubuntu@your-ip

# Install n8n
npm install -g n8n

# Start n8n
n8n start

# Access at: http://your-ip:5678
```

### Docker Compose

```yaml
version: '3'
services:
  n8n:
    image: n8nio/n8n
    ports:
      - "5678:5678"
    environment:
      - DB_TYPE=sqlite
      - GENERIC_TIMEZONE=UTC
    volumes:
      - n8n_data:/home/node/.n8n
      
volumes:
  n8n_data:
```

## Monitoring

1. **Execution logs** - Check n8n Executions tab
2. **Webhook calls** - Test with curl or Postman
3. **Slack notifications** - Check `#churn-risk-alerts` channel
4. **Jira tickets** - Check your project for "URGENT" tickets
5. **Calendar** - Check your Google Calendar for 15-min meetings

## Next Steps

- [ ] Configure Slack channel name
- [ ] Customize Jira ticket template
- [ ] Add more integrations (SendGrid, PagerDuty, etc.)
- [ ] Fine-tune risk thresholds
- [ ] Set up monitoring/alerting
- [ ] Document company-specific pain points
