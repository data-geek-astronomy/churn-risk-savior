# 🤗 Deploy to Hugging Face Spaces

## Step 1: Create a Hugging Face Account

1. Go to https://huggingface.co/join
2. Sign up with your email or GitHub
3. Verify your email

## Step 2: Create a New Space

1. Go to https://huggingface.co/spaces
2. Click **"Create new Space"**
3. Fill in:
   - **Space name:** `churn-risk-savior`
   - **Owner:** Select your account
   - **SDK:** Select **Streamlit**
   - **License:** MIT
4. Click **"Create Space"**

## Step 3: Connect GitHub

You'll be taken to your Space. Now connect your GitHub repo:

1. Click **"Files and Versions"** tab
2. Click **"Clone repository"**
3. In terminal:

```bash
cd ~/Documents  # Choose a location
git clone https://huggingface.co/spaces/yourusername/churn-risk-savior
cd churn-risk-savior
```

4. Add your GitHub repo as a second remote:

```bash
git remote add github https://github.com/yourusername/churn-risk-savior.git
git pull github main --allow-unrelated-histories
git push origin main
```

## Step 4: Update Files

The space will automatically use your repo's files. Make sure:

- ✅ `app.py` - Main Streamlit app (already there)
- ✅ `requirements.txt` - Dependencies (already there)
- ✅ `README.md` - Documentation (already there)
- ✅ `spaces-config.yaml` - Space configuration (already there)

## Step 5: Add Secrets (Optional)

If you want to use environment variables in the Space:

1. Go to your Space
2. Click **"Settings"** → **"Repository secrets"**
3. Add secrets like:
   - `OPENAI_API_KEY` → your OpenAI key (optional, not needed for demo)

## Step 6: Deploy

1. Push changes to Hugging Face:

```bash
git push origin main
```

2. The Space will auto-deploy (watch the logs in the Space UI)
3. Once deployed, your Space will be live at:
   ```
   https://huggingface.co/spaces/yourusername/churn-risk-savior
   ```

## Step 7: Share!

1. Click **"Embed in your website"** to get an iframe
2. Share the Space URL
3. Add to your portfolio/resume

## Troubleshooting

### "Requirements not installing"
- Make sure `requirements.txt` has correct format
- Check Python version (should be 3.9+)

### "App won't start"
- Check Space logs (bottom right)
- Look for error messages
- Verify API endpoint URL in `app.py`

### "Streamlit not finding app.py"
- Make sure file is in the root directory
- Check the `app_file` in `spaces-config.yaml`

## Environment Variables

If you need secrets (like API keys):

1. Click **Settings** in your Space
2. Add them under **Repository secrets**
3. In your `app.py`, access them with:

```python
import os
openai_key = os.getenv("OPENAI_API_KEY")
```

## Keep in Sync

To keep Hugging Face Spaces synced with GitHub:

```bash
# In ~/churn-risk-savior-portfolio
git push github main  # Push to GitHub
git push origin main  # Push to HF Spaces
```

Or set up bidirectional sync in GitHub Actions.

## Example Output

Once deployed, visitors can:

1. **Test the AI agent** - Paste support tickets
2. **See real-time analysis** - Risk scores, sentiment, actions
3. **Review sample cases** - Pre-built test scenarios
4. **View integrations** - What happens on escalation

## Make it Private

If needed, make your Space private:

1. Go to Space settings
2. Change visibility to **Private**
3. Only you can access it

## Analytics

Hugging Face Spaces provides:
- Visit count
- Unique visitors
- Geographic distribution
- Referring traffic

Check **"Logs"** tab to monitor.

## Delete Space

To remove the Space later:

1. Go to Space settings
2. Scroll to bottom
3. Click **"Delete this Space"**

---

**Done! Your portfolio is now live on Hugging Face Spaces 🎉**

Share your Space URL in interviews, portfolios, and social media!
