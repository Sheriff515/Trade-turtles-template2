# Turtles Charts: turn on accounts and private cloud saving

The app works as it is. Accounts are optional and stay switched off until you do steps 1 to 4.

## 1. Create the Supabase project (free)
supabase.com -> New project. Wait until it is ready.

## 2. Create the private storage
Supabase -> SQL Editor -> New query -> paste everything from `supabase-setup.sql` -> Run.
This makes a private bucket called `tt` where each user can only reach their own folder.

## 3. Put your two keys in index.html
Supabase -> Project Settings -> API. Copy the **Project URL** and the **anon / publishable key**.
Open `index.html`, search for `SB_URL`, and paste them between the quotes:

    const SB_URL='https://YOURPROJECT.supabase.co',SB_KEY='your-anon-key';

The anon key is meant to be public. NEVER paste the service_role / secret key.

## 4. Tell Supabase your website address
Supabase -> Authentication -> URL Configuration:
- Site URL: your Vercel address, for example https://turtles-charts.vercel.app
- Redirect URLs: add the same address.
Optional: Authentication -> Providers -> Google, to use "Continue with Google".
Recommended: Authentication -> Sign In / Providers -> Email: keep "Confirm email" on.

## 5. Deploy the whole folder to Vercel
Drag this folder into Vercel. Keep every file in it, including `vercel.json`.
If your Supabase project uses a custom domain, replace `*.supabase.co` in `vercel.json` with it.

## Notes
- Designs live on the device and sync to the account every 30 seconds, when you return to "My designs", when the app is hidden, and when the internet comes back.
- Signing out removes the designs from that device (they stay in your account). A device that never moved its designs into an account keeps them.
- To roll back, redeploy an earlier deployment from the Vercel Deployments list.
