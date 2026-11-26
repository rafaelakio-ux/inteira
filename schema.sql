-- Initial schema proposal. Apply only to a test Supabase project after reviewing policies.
create table public.clients (id uuid primary key default gen_random_uuid(), name text not null, segment text, drive_folder_id text, logo_file_id text, created_at timestamptz not null default now());
create table public.client_members (client_id uuid references public.clients on delete cascade, user_id uuid references auth.users on delete cascade, role text not null check(role in ('manager','staff','client')), primary key(client_id,user_id));
create table public.client_records (id uuid primary key default gen_random_uuid(), client_id uuid not null references public.clients on delete cascade, kind text not null check(kind in ('task','metric','funnel','plan','calendar','art','report','alert','delivery')), status text not null default 'draft', payload jsonb not null default '{}', created_at timestamptz not null default now(), created_by uuid references auth.users default auth.uid());
create table public.portal_usage (client_id uuid references public.clients on delete cascade, day date not null, requests integer not null default 0 check(requests>=0), primary key(client_id,day));
create table public.portal_limits (client_id uuid primary key references public.clients on delete cascade, daily_limit integer not null default 3 check(daily_limit>=0));
alter table public.clients enable row level security;
alter table public.client_members enable row level security;
alter table public.client_records enable row level security;
alter table public.portal_usage enable row level security;
alter table public.portal_limits enable row level security;
create policy member_read_self on public.client_members for select to authenticated using(user_id=auth.uid());
create policy clients_read on public.clients for select to authenticated using(exists(select 1 from public.client_members m where m.client_id=id and m.user_id=auth.uid()));
create policy staff_read_records on public.client_records for select to authenticated using(exists(select 1 from public.client_members m where m.client_id=client_records.client_id and m.user_id=auth.uid() and m.role in ('manager','staff')));
create policy staff_create_records on public.client_records for insert to authenticated with check(created_by=auth.uid() and exists(select 1 from public.client_members m where m.client_id=client_records.client_id and m.user_id=auth.uid() and m.role in ('manager','staff')));
-- External portal intentionally has NO direct record access until a sanitized, server-side projection is implemented.
-- Membership, approval updates, usage increments and limits are intentionally server-managed only.
