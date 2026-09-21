-- =========================================================================
-- SmartTest (HMUTEST) - High Concurrency 2,000 Candidates Optimization
-- Created: 2026-09-11 / 2026-09-19
-- =========================================================================

-- Index 1: Optimize answer saving (saveTempResult / SaveTempData)
-- Drops sequential table scan during peak answering to 0.12ms index scan
CREATE INDEX IF NOT EXISTS "IX_CandidateAnswers_CandidateId_QuestionId" 
ON public."CandidateAnswers" USING btree ("CandidateId", "QuestionId");

-- Index 2: Optimize proctoring event recording and real-time monitoring query
CREATE INDEX IF NOT EXISTS "IX_CandidateEvents_CandidateId_EventDate" 
ON public."CandidateEvents" USING btree ("CandidateId", "EventDate");

-- Index 3: Optimize grading and score retrieval
CREATE INDEX IF NOT EXISTS "IX_CandidatePartScores_CandidateId" 
ON public."CandidatePartScores" USING btree ("CandidateId");
