-- Trenažér výrokovej logiky: databáza pre postup používateľov
-- Spusti raz v Supabase: SQL Editor → New query → vlož celý tento súbor → Run.

create table if not exists public.progress (
  user_id    uuid primary key references auth.users (id) on delete cascade,
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- Každý používateľ vidí a mení len svoj vlastný riadok.
alter table public.progress enable row level security;

drop policy if exists "vlastny postup citanie" on public.progress;
drop policy if exists "vlastny postup vlozenie" on public.progress;
drop policy if exists "vlastny postup uprava" on public.progress;

create policy "vlastny postup citanie" on public.progress
  for select to authenticated using (auth.uid() = user_id);

create policy "vlastny postup vlozenie" on public.progress
  for insert to authenticated with check (auth.uid() = user_id);

create policy "vlastny postup uprava" on public.progress
  for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
