# Publishing Workflow

How I'm publishing each week's blog post.

## Write

- Write the post in blog/week-XX.md
- Add screenshots to assets/images/week-XX/
- Make sure no secrets are in there
- Quick review before publishing

## Publish to GitHub Pages

1. Commit and push:
   ```bash
   git add blog/week-XX.md assets/images/week-XX/
   git commit -m "Add Week XX blog post"
   git push origin main
   ```

2. GitHub Actions should auto-publish to GitHub Pages
3. Check it at https://scriptpy.github.io/devsecops-lab-under-500/blog/week-XX

## Cross-post to Medium

1. Go to Medium.com, click Write
2. Import a story, paste the GitHub Pages URL
3. Add canonical link:
   ```html
   <link rel="canonical" href="https://scriptpy.github.io/devsecops-lab-under-500/blog/week-XX">
   ```
4. Add tags: devsecops, cybersecurity, kali-linux, homelab, learning
5. Publish

## Share on LinkedIn

Write a short post about what I did this week, include link to blog post, use hashtags like #DevSecOps #CyberSecurity #Homelab #LearningInPublic

## Update Index

- Add link to README.md
- Update budget.md with costs
- Update runbook if needed

## Weekly Checklist

- [ ] Blog post done
- [ ] Screenshots added
- [ ] No secrets in post
- [ ] Pushed to GitHub
- [ ] Cross-posted to Medium
- [ ] Shared on LinkedIn
- [ ] README updated
- [ ] Budget updated

## Tips

- Try to publish same day each week
- Respond to comments
- Share on Reddit (r/devops, r/cybersecurity) if helpful
- Include screenshots and code snippets
- Be honest about challenges, not just successes

