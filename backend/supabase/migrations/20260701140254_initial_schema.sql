-- =========================================================
-- Waffer XP - Initial Schema
-- =========================================================

create extension if not exists pgcrypto;

-- =========================================================
-- ENUMS
-- =========================================================

create type public.goal_status as enum (
  'active',
  'paused',
  'completed',
  'cancelled'
);

create type public.saving_method as enum (
  'round_up',
  'monthly',
  'timed_challenge',
  'manual'
);

create type public.challenge_status as enum (
  'not_started',
  'active',
  'completed',
  'failed'
);

create type public.notification_type as enum (
  'reminder',
  'milestone',
  'achievement',
  'challenge',
  'system'
);

-- =========================================================
-- PROFILES
-- Supabase Auth already stores login credentials.
-- This table stores app-specific user information.
-- =========================================================

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,

  full_name text,
  avatar_url text,

  xp integer not null default 0
    check (xp >= 0),

  level integer not null default 1
    check (level >= 1),

  current_streak integer not null default 0
    check (current_streak >= 0),

  longest_streak integer not null default 0
    check (longest_streak >= 0),

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- =========================================================
-- SAVINGS GOALS
-- =========================================================

create table public.savings_goals (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null
    references auth.users(id)
    on delete cascade,

  name text not null,
  description text,

  target_amount numeric(12, 2) not null
    check (target_amount > 0),

  saved_amount numeric(12, 2) not null default 0
    check (saved_amount >= 0),

  currency text not null default 'SAR',

  deadline date,

  saving_method public.saving_method not null default 'manual',
  status public.goal_status not null default 'active',

  is_primary boolean not null default false,

  icon_name text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  completed_at timestamptz,

  constraint saved_amount_not_above_target
    check (saved_amount <= target_amount)
);

create index savings_goals_user_id_idx
on public.savings_goals(user_id);

create index savings_goals_status_idx
on public.savings_goals(user_id, status);

create unique index one_primary_goal_per_user
on public.savings_goals(user_id)
where is_primary = true
and status in ('active', 'paused');

-- =========================================================
-- SAVING METHOD SETTINGS
-- Stores settings depending on the selected method.
-- =========================================================

create table public.saving_method_settings (
  id uuid primary key default gen_random_uuid(),

  goal_id uuid not null unique
    references public.savings_goals(id)
    on delete cascade,

  round_up_to numeric(8, 2),
  round_up_multiplier numeric(5, 2),

  monthly_amount numeric(12, 2),
  monthly_payment_day smallint,

  challenge_duration_days integer,
  challenge_daily_amount numeric(12, 2),

  auto_save_enabled boolean not null default false,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint valid_monthly_payment_day
    check (
      monthly_payment_day is null
      or monthly_payment_day between 1 and 28
    ),

  constraint positive_monthly_amount
    check (
      monthly_amount is null
      or monthly_amount > 0
    ),

  constraint positive_duration
    check (
      challenge_duration_days is null
      or challenge_duration_days > 0
    )
);

-- =========================================================
-- SAVINGS TRANSACTIONS
-- Each contribution or withdrawal is recorded here.
-- =========================================================

create table public.savings_transactions (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null
    references auth.users(id)
    on delete cascade,

  goal_id uuid not null
    references public.savings_goals(id)
    on delete cascade,

  amount numeric(12, 2) not null
    check (amount <> 0),

  transaction_type text not null
    check (
      transaction_type in (
        'manual_saving',
        'round_up',
        'monthly_saving',
        'challenge_saving',
        'withdrawal',
        'adjustment'
      )
    ),

  description text,
  merchant_name text,

  created_at timestamptz not null default now()
);

create index savings_transactions_goal_id_idx
on public.savings_transactions(goal_id, created_at desc);

create index savings_transactions_user_id_idx
on public.savings_transactions(user_id, created_at desc);

-- =========================================================
-- MILESTONES
-- =========================================================

create table public.milestones (
  id uuid primary key default gen_random_uuid(),

  goal_id uuid not null
    references public.savings_goals(id)
    on delete cascade,

  percentage integer not null
    check (percentage between 1 and 100),

  xp_reward integer not null default 0
    check (xp_reward >= 0),

  reached_at timestamptz,

  created_at timestamptz not null default now(),

  unique (goal_id, percentage)
);

-- =========================================================
-- CHALLENGES
-- General challenge catalogue.
-- =========================================================

create table public.challenges (
  id uuid primary key default gen_random_uuid(),

  title text not null,
  description text,

  duration_days integer not null
    check (duration_days > 0),

  target_amount numeric(12, 2)
    check (target_amount is null or target_amount > 0),

  xp_reward integer not null default 0
    check (xp_reward >= 0),

  is_active boolean not null default true,

  created_at timestamptz not null default now()
);

-- =========================================================
-- USER CHALLENGES
-- Tracks the user's participation and progress.
-- =========================================================

create table public.user_challenges (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null
    references auth.users(id)
    on delete cascade,

  challenge_id uuid not null
    references public.challenges(id)
    on delete cascade,

  goal_id uuid
    references public.savings_goals(id)
    on delete set null,

  status public.challenge_status not null default 'not_started',

  progress_amount numeric(12, 2) not null default 0
    check (progress_amount >= 0),

  started_at timestamptz,
  completed_at timestamptz,

  created_at timestamptz not null default now(),

  unique (user_id, challenge_id)
);

-- =========================================================
-- ACHIEVEMENTS
-- =========================================================

create table public.achievements (
  id uuid primary key default gen_random_uuid(),

  name text not null unique,
  description text,

  icon_name text,

  xp_reward integer not null default 0
    check (xp_reward >= 0),

  created_at timestamptz not null default now()
);

-- =========================================================
-- USER ACHIEVEMENTS
-- =========================================================

create table public.user_achievements (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null
    references auth.users(id)
    on delete cascade,

  achievement_id uuid not null
    references public.achievements(id)
    on delete cascade,

  unlocked_at timestamptz not null default now(),

  unique (user_id, achievement_id)
);

-- =========================================================
-- RECOVERY PLANS
-- Supports the recovery screens in the prototype.
-- =========================================================

create table public.recovery_plans (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null
    references auth.users(id)
    on delete cascade,

  goal_id uuid not null
    references public.savings_goals(id)
    on delete cascade,

  original_deadline date,
  new_deadline date,

  original_monthly_amount numeric(12, 2),
  new_monthly_amount numeric(12, 2),

  reason text,

  is_active boolean not null default true,

  created_at timestamptz not null default now(),
  completed_at timestamptz
);

-- =========================================================
-- NOTIFICATIONS
-- =========================================================

create table public.notifications (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null
    references auth.users(id)
    on delete cascade,

  title text not null,
  body text not null,

  type public.notification_type not null default 'system',

  is_read boolean not null default false,

  created_at timestamptz not null default now()
);

create index notifications_user_id_idx
on public.notifications(user_id, created_at desc);

-- =========================================================
-- UPDATED_AT FUNCTION
-- =========================================================

create or replace function public.set_updated_at()
returns trigger
language plpgsql
security invoker
set search_path = public
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger set_profiles_updated_at
before update on public.profiles
for each row
execute function public.set_updated_at();

create trigger set_savings_goals_updated_at
before update on public.savings_goals
for each row
execute function public.set_updated_at();

create trigger set_saving_method_settings_updated_at
before update on public.saving_method_settings
for each row
execute function public.set_updated_at();

-- =========================================================
-- CREATE PROFILE AFTER SIGNUP
-- =========================================================

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (
    id,
    full_name
  )
  values (
    new.id,
    coalesce(
      new.raw_user_meta_data ->> 'full_name',
      new.raw_user_meta_data ->> 'name'
    )
  );

  return new;
end;
$$;

create trigger on_auth_user_created
after insert on auth.users
for each row
execute function public.handle_new_user();

-- =========================================================
-- UPDATE GOAL BALANCE AFTER TRANSACTION
-- =========================================================

create or replace function public.update_goal_balance()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  update public.savings_goals
  set
    saved_amount = greatest(
      0,
      least(target_amount, saved_amount + new.amount)
    ),
    status = case
      when saved_amount + new.amount >= target_amount
        then 'completed'::public.goal_status
      else status
    end,
    completed_at = case
      when saved_amount + new.amount >= target_amount
        then now()
      else completed_at
    end
  where id = new.goal_id
    and user_id = new.user_id;

  return new;
end;
$$;

create trigger update_goal_after_transaction
after insert on public.savings_transactions
for each row
execute function public.update_goal_balance();

-- =========================================================
-- GOAL SUMMARY VIEW
-- =========================================================

create view public.savings_goal_summary
with (security_invoker = true)
as
select
  id,
  user_id,
  name,
  description,
  target_amount,
  saved_amount,
  currency,
  deadline,
  saving_method,
  status,
  is_primary,
  icon_name,

  round(
    (saved_amount / target_amount) * 100,
    2
  ) as progress_percentage,

  greatest(
    target_amount - saved_amount,
    0
  ) as remaining_amount,

  created_at,
  updated_at,
  completed_at
from public.savings_goals;

-- =========================================================
-- ROW LEVEL SECURITY
-- =========================================================

alter table public.profiles enable row level security;
alter table public.savings_goals enable row level security;
alter table public.saving_method_settings enable row level security;
alter table public.savings_transactions enable row level security;
alter table public.milestones enable row level security;
alter table public.challenges enable row level security;
alter table public.user_challenges enable row level security;
alter table public.achievements enable row level security;
alter table public.user_achievements enable row level security;
alter table public.recovery_plans enable row level security;
alter table public.notifications enable row level security;

-- =========================================================
-- PROFILE POLICIES
-- =========================================================

create policy "Users can view their profile"
on public.profiles
for select
to authenticated
using (auth.uid() = id);

create policy "Users can update their profile"
on public.profiles
for update
to authenticated
using (auth.uid() = id)
with check (auth.uid() = id);

-- =========================================================
-- SAVINGS GOAL POLICIES
-- =========================================================

create policy "Users can view their goals"
on public.savings_goals
for select
to authenticated
using (auth.uid() = user_id);

create policy "Users can create goals"
on public.savings_goals
for insert
to authenticated
with check (auth.uid() = user_id);

create policy "Users can update goals"
on public.savings_goals
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

create policy "Users can delete goals"
on public.savings_goals
for delete
to authenticated
using (auth.uid() = user_id);

-- =========================================================
-- METHOD SETTINGS POLICIES
-- =========================================================

create policy "Users can view goal settings"
on public.saving_method_settings
for select
to authenticated
using (
  exists (
    select 1
    from public.savings_goals
    where savings_goals.id = saving_method_settings.goal_id
      and savings_goals.user_id = auth.uid()
  )
);

create policy "Users can create goal settings"
on public.saving_method_settings
for insert
to authenticated
with check (
  exists (
    select 1
    from public.savings_goals
    where savings_goals.id = saving_method_settings.goal_id
      and savings_goals.user_id = auth.uid()
  )
);

create policy "Users can update goal settings"
on public.saving_method_settings
for update
to authenticated
using (
  exists (
    select 1
    from public.savings_goals
    where savings_goals.id = saving_method_settings.goal_id
      and savings_goals.user_id = auth.uid()
  )
)
with check (
  exists (
    select 1
    from public.savings_goals
    where savings_goals.id = saving_method_settings.goal_id
      and savings_goals.user_id = auth.uid()
  )
);

create policy "Users can delete goal settings"
on public.saving_method_settings
for delete
to authenticated
using (
  exists (
    select 1
    from public.savings_goals
    where savings_goals.id = saving_method_settings.goal_id
      and savings_goals.user_id = auth.uid()
  )
);

-- =========================================================
-- TRANSACTION POLICIES
-- =========================================================

create policy "Users can view transactions"
on public.savings_transactions
for select
to authenticated
using (auth.uid() = user_id);

create policy "Users can create transactions"
on public.savings_transactions
for insert
to authenticated
with check (
  auth.uid() = user_id
  and exists (
    select 1
    from public.savings_goals
    where savings_goals.id = savings_transactions.goal_id
      and savings_goals.user_id = auth.uid()
  )
);

-- =========================================================
-- MILESTONE POLICIES
-- =========================================================

create policy "Users can view their milestones"
on public.milestones
for select
to authenticated
using (
  exists (
    select 1
    from public.savings_goals
    where savings_goals.id = milestones.goal_id
      and savings_goals.user_id = auth.uid()
  )
);

-- =========================================================
-- PUBLIC CATALOGUE POLICIES
-- Challenges and achievements can be viewed by users.
-- =========================================================

create policy "Authenticated users can view challenges"
on public.challenges
for select
to authenticated
using (true);

create policy "Authenticated users can view achievements"
on public.achievements
for select
to authenticated
using (true);

-- =========================================================
-- USER CHALLENGE POLICIES
-- =========================================================

create policy "Users can view their challenges"
on public.user_challenges
for select
to authenticated
using (auth.uid() = user_id);

create policy "Users can join challenges"
on public.user_challenges
for insert
to authenticated
with check (auth.uid() = user_id);

create policy "Users can update their challenges"
on public.user_challenges
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- =========================================================
-- USER ACHIEVEMENT POLICIES
-- =========================================================

create policy "Users can view their achievements"
on public.user_achievements
for select
to authenticated
using (auth.uid() = user_id);

-- =========================================================
-- RECOVERY PLAN POLICIES
-- =========================================================

create policy "Users can view recovery plans"
on public.recovery_plans
for select
to authenticated
using (auth.uid() = user_id);

create policy "Users can create recovery plans"
on public.recovery_plans
for insert
to authenticated
with check (
  auth.uid() = user_id
  and exists (
    select 1
    from public.savings_goals
    where savings_goals.id = recovery_plans.goal_id
      and savings_goals.user_id = auth.uid()
  )
);

create policy "Users can update recovery plans"
on public.recovery_plans
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- =========================================================
-- NOTIFICATION POLICIES
-- =========================================================

create policy "Users can view notifications"
on public.notifications
for select
to authenticated
using (auth.uid() = user_id);

create policy "Users can update notifications"
on public.notifications
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);