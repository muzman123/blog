#!/bin/bash
# Script to deploy the LLaDA blog post

cd /home/vbox/blog

echo "Adding new blog post files..."
git add posts/llada-diffusion-models/
git add index.html
git add images/post-covers/llada-diffusion.svg
git add images/post-content/diffusion-process.svg
git add images/post-content/autoregressive-vs-diffusion.svg

echo "Removing hello.txt (already deleted via git)..."
# hello.txt was already removed by the approved command

echo "Committing changes..."
git commit -m "Add LLaDA diffusion models blog post with diagrams"

echo "Pushing to GitHub..."
git push origin main

echo "Done! Blog post is live."
