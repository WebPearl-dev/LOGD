-- Supabase Schema for Chat, DMs, PvP and Inn Safe Haven in Legend of the Golden Dragon

-- 1. Add new columns to profiles table if they don't exist
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS honor INTEGER DEFAULT 0;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS pvp_wins INTEGER DEFAULT 0;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS pvp_losses INTEGER DEFAULT 0;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS is_resting_in_inn BOOLEAN DEFAULT FALSE;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS bio TEXT DEFAULT '';

-- 2. Global Chat table
CREATE TABLE IF NOT EXISTS global_chat (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sender_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    sender_username TEXT NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS for global_chat
ALTER TABLE global_chat ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read global chat" ON global_chat FOR SELECT USING (true);
CREATE POLICY "Authenticated users can insert global chat" ON global_chat FOR INSERT WITH CHECK (auth.uid() = sender_id);

-- 3. Direct Messages table
CREATE TABLE IF NOT EXISTS direct_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sender_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    receiver_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    sender_username TEXT NOT NULL,
    receiver_username TEXT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS for direct_messages
ALTER TABLE direct_messages ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read their own direct messages" ON direct_messages FOR SELECT USING (auth.uid() = sender_id OR auth.uid() = receiver_id);
CREATE POLICY "Authenticated users can insert direct messages" ON direct_messages FOR INSERT WITH CHECK (auth.uid() = sender_id);
CREATE POLICY "Users can update their received direct messages (e.g. mark read)" ON direct_messages FOR UPDATE USING (auth.uid() = receiver_id);

-- 4. PvP Challenges table
CREATE TABLE IF NOT EXISTS pvp_challenges (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    challenger_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    opponent_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    challenger_username TEXT NOT NULL,
    opponent_username TEXT NOT NULL,
    wager INTEGER NOT NULL DEFAULT 0,
    status TEXT NOT NULL DEFAULT 'pending', -- pending, accepted, declined, completed
    winner_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
    combat_log TEXT DEFAULT '',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS for pvp_challenges
ALTER TABLE pvp_challenges ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read their own PvP challenges" ON pvp_challenges FOR SELECT USING (auth.uid() = challenger_id OR auth.uid() = opponent_id);
CREATE POLICY "Authenticated users can insert PvP challenges" ON pvp_challenges FOR INSERT WITH CHECK (auth.uid() = challenger_id);
CREATE POLICY "Users can update their PvP challenges" ON pvp_challenges FOR UPDATE USING (auth.uid() = challenger_id OR auth.uid() = opponent_id);

-- Enable Realtime for global_chat and direct_messages and pvp_challenges
ALTER PUBLICATION supabase_realtime ADD TABLE global_chat;
ALTER PUBLICATION supabase_realtime ADD TABLE direct_messages;
ALTER PUBLICATION supabase_realtime ADD TABLE pvp_challenges;

-- 5. Blocked Users table
CREATE TABLE IF NOT EXISTS blocked_users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    blocked_user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS for blocked_users
ALTER TABLE blocked_users ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read their own blocked users" ON blocked_users FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Authenticated users can insert blocked users" ON blocked_users FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can delete their own blocked users" ON blocked_users FOR DELETE USING (auth.uid() = user_id);

-- 6. Reports table
CREATE TABLE IF NOT EXISTS reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    reporter_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    reported_user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    reason TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS for reports
ALTER TABLE reports ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can insert reports" ON reports FOR INSERT WITH CHECK (auth.uid() = reporter_id);
CREATE POLICY "Users can read their own reports" ON reports FOR SELECT USING (auth.uid() = reporter_id);

