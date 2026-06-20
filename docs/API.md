# API Reference

## Webhook Endpoint

**Base URL:** `https://aravind5.app.n8n.cloud/webhook/churn-risk`

### Request

**Method:** `POST`

**Headers:**
```json
{
  "Content-Type": "application/json"
}
```

**Body:**
```json
{
  "message": "Your customer support message here"
}
```

### Response

**Status:** `200 OK`

**Body:**
```json
{
  "status": "ESCALATED",
  "risk_level": "HIGH",
  "risk_score": 95,
  "sentiment": "Angry",
  "urgency": "Immediate",
  "pain_points": "overcharging, competitor comparison",
  "recommended_action": "Immediately escalate to the Billing Manager...",
  "auto_reply": "Hello, I am deeply sorry to hear...",
  "alert": "CRITICAL: HIGH CHURN RISK Score=95/100 | Sentiment: Angry...",
  "processed_at": "2026-06-20T03:00:19.088-07:00"
}
```

### Status Codes

| Code | Meaning |
|------|---------|
| 200 | Success |
| 400 | Bad request (invalid JSON) |
| 500 | Server error |

## Response Fields

| Field | Type | Description |
|-------|------|-------------|
| `status` | string | Action status: `ESCALATED`, `FOLLOW_UP_QUEUED`, `AUTO_RESOLVED` |
| `risk_level` | string | Risk classification: `HIGH`, `MEDIUM`, `LOW` |
| `risk_score` | number | Churn risk score (0-100) |
| `sentiment` | string | Customer sentiment: `Angry`, `Frustrated`, `Neutral`, etc. |
| `urgency` | string | Action urgency: `Immediate`, `Within 24h`, `Within 1 week` |
| `pain_points` | string | Extracted customer pain points |
| `recommended_action` | string | AI-generated action plan for support team |
| `auto_reply` | string | Professional auto-reply to send to customer |
| `alert` | string | Formatted alert message for team |
| `processed_at` | timestamp | ISO 8601 timestamp of analysis |

## Examples

### Example 1: HIGH Risk

```bash
curl -X POST https://aravind5.app.n8n.cloud/webhook/churn-risk \
  -H "Content-Type: application/json" \
  -d '{
    "message": "I have been overcharged 3 months in a row. This is completely unacceptable. I am switching to your competitor if this is not fixed today."
  }'
```

**Response:**
```json
{
  "status": "ESCALATED",
  "risk_level": "HIGH",
  "risk_score": 95,
  "sentiment": "Angry",
  "urgency": "Immediate",
  "pain_points": "repeated overcharging, switching to competitor",
  "recommended_action": "Immediately escalate to the Billing Manager and Customer Retention lead.",
  "auto_reply": "We sincerely apologize for the repeated overcharges. This has been escalated to our Billing Manager for immediate resolution.",
  "alert": "CRITICAL: HIGH CHURN RISK Score=95/100 | Sentiment: Angry | Urgency: Immediate",
  "processed_at": "2026-06-20T03:00:19.088Z"
}
```

### Example 2: MEDIUM Risk

```bash
curl -X POST https://aravind5.app.n8n.cloud/webhook/churn-risk \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Hey, I have had a few issues with your app lately. The loading times are pretty slow and it is getting a bit frustrating."
  }'
```

**Response:**
```json
{
  "status": "FOLLOW_UP_QUEUED",
  "risk_level": "MEDIUM",
  "risk_score": 45,
  "sentiment": "Frustrated",
  "urgency": "Within 24 hours",
  "pain_points": "slow loading times",
  "recommended_action": "Assign a technical support specialist to review account latency logs.",
  "auto_reply": "I'm truly sorry to hear you've been experiencing slow loading times. I've flagged this with our technical team.",
  "alert": "WARNING: MEDIUM CHURN RISK Score=45/100 | Sentiment: Frustrated",
  "processed_at": "2026-06-20T03:01:34.368Z"
}
```

### Example 3: LOW Risk

```bash
curl -X POST https://aravind5.app.n8n.cloud/webhook/churn-risk \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Hi, could you help me understand how to export my data to CSV? Thanks!"
  }'
```

**Response:**
```json
{
  "status": "AUTO_RESOLVED",
  "risk_level": "LOW",
  "risk_score": 15,
  "sentiment": "Neutral",
  "urgency": "No immediate action",
  "pain_points": "data export feature clarity",
  "recommended_action": "Provide the customer with documentation link for CSV exports.",
  "auto_reply": "Thank you for reaching out! Exporting your data to CSV is a straightforward process.",
  "alert": "OK: LOW CHURN RISK Score=15/100 - Auto-resolved",
  "processed_at": "2026-06-20T03:03:06.314Z"
}
```

## Rate Limits

- **Requests/second:** 100+
- **Concurrent requests:** Unlimited
- **Monthly volume:** 10,000+ free

## Integration Examples

### Python

```python
import requests

response = requests.post(
    "https://aravind5.app.n8n.cloud/webhook/churn-risk",
    json={"message": "Customer message here"}
)

result = response.json()
print(f"Risk Level: {result['risk_level']}")
print(f"Risk Score: {result['risk_score']}")
print(f"Action: {result['recommended_action']}")
```

### JavaScript/Node.js

```javascript
const response = await fetch('https://aravind5.app.n8n.cloud/webhook/churn-risk', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ message: 'Customer message here' })
});

const result = await response.json();
console.log(`Risk Level: ${result.risk_level}`);
console.log(`Risk Score: ${result.risk_score}`);
```

### cURL

```bash
curl -X POST https://aravind5.app.n8n.cloud/webhook/churn-risk \
  -H "Content-Type: application/json" \
  -d '{"message": "customer message"}'
```

## Error Handling

All errors return JSON with an error message:

```json
{
  "code": "INVALID_REQUEST",
  "message": "Message field is required"
}
```

Common error codes:
- `INVALID_REQUEST` - Missing or invalid parameters
- `API_ERROR` - OpenAI API error
- `INTEGRATION_ERROR` - Slack/Jira/Calendar error
- `SERVER_ERROR` - Internal server error
