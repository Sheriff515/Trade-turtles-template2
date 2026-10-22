-- Turtles Charts: private per-user storage.
-- Run this once in Supabase: Dashboard -> SQL Editor -> New query -> paste -> Run.

-- 1) A PRIVATE bucket called "tt" (JSON files only, 20 MB max each).
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('tt', 'tt', false, 20971520, array['application/json'])
on conflict (id) do update
  set public = false,
      file_size_limit = 20971520,
      allowed_mime_types = array['application/json'];

-- 2) Each signed-in user can only touch files inside the folder named after their own user id.
drop policy if exists "tt read own"   on storage.objects;
drop policy if exists "tt insert own" on storage.objects;
drop policy if exists "tt update own" on storage.objects;
drop policy if exists "tt delete own" on storage.objects;

create policy "tt read own" on storage.objects for select to authenticated
  using (bucket_id = 'tt' and (storage.foldername(name))[1] = (select auth.uid()::text));

create policy "tt insert own" on storage.objects for insert to authenticated
  with check (bucket_id = 'tt' and (storage.foldername(name))[1] = (select auth.uid()::text));

create policy "tt update own" on storage.objects for update to authenticated
  using (bucket_id = 'tt' and (storage.foldername(name))[1] = (select auth.uid()::text))
  with check (bucket_id = 'tt' and (storage.foldername(name))[1] = (select auth.uid()::text));

create policy "tt delete own" on storage.objects for delete to authenticated
  using (bucket_id = 'tt' and (storage.foldername(name))[1] = (select auth.uid()::text));
