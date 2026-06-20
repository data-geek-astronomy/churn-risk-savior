#!/bin/bash

# 🚀 EXACT DEPLOY COMMANDS FOR: data-geek-astronomy

echo "📦 Setting up GitHub deployment..."

cd ~/churn-risk-savior-portfolio

# Step 1: Configure git
git config user.email "aravind.kumar.nalukurthi@gmail.com"
git config user.name "Aravind Kumar"

# Step 2: Create GitHub repo first!
echo ""
echo "⚠️  IMPORTANT: Create repo first at:"
echo "   https://github.com/new"
echo ""
echo "Name: churn-risk-savior"
echo "Description: AI Customer Churn Risk Savior - Production-grade churn detection & escalation"
echo "Visibility: PUBLIC"
echo "Do NOT initialize with README"
echo ""
read -p "Press ENTER after you create the repo..."

# Step 3: Push to GitHub
git remote add origin https://github.com/data-geek-astronomy/churn-risk-savior.git
git branch -M main
git push -u origin main

echo ""
echo "✅ GitHub push complete!"
echo "🔗 Your repo: https://github.com/data-geek-astronomy/churn-risk-savior"
echo ""
echo "📋 Next: Deploy to Hugging Face Spaces"
echo "   Follow: HF_SPACES_DEPLOYMENT.md"

