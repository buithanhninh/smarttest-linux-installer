-- Script schema PostgreSQL — sinh tự động từ T-SQL bằng tools/mssql2pg.py
-- Tên bảng/cột giữ nguyên chữ hoa (bọc "...") để code không phải đổi.

CREATE EXTENSION IF NOT EXISTS citext;

CREATE TABLE "AccessDeviceFaces" (
    "OwnerType" smallint NOT NULL,
    "OwnerId" bigint NOT NULL,
    "DeviceId" bigint NOT NULL,
    "Status" smallint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_AccessDeviceFaces" PRIMARY KEY ("Id")
);

CREATE TABLE "AccessDevices" (
    "Name" citext NOT NULL,
    "Ip" varchar(100),
    "DeviceNo" varchar(50),
    "UserName" citext,
    "Password" citext,
    "DeviceType" smallint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_AccessDevices" PRIMARY KEY ("Id")
);

CREATE TABLE "ActivityData" (
    "ActivityId" bigint NOT NULL,
    "PlayingData" text NOT NULL,
    "YearPart" integer NOT NULL,
    "Instruction" citext,
    CONSTRAINT "PK_ActivityData" PRIMARY KEY ("ActivityId")
);

CREATE TABLE "AnswerContents" (
    "AnswerId" bigint NOT NULL,
    "AnswerContent" bytea,
    "TextContent" text,
    CONSTRAINT "PK_AnswerContents" PRIMARY KEY ("AnswerId")
);

CREATE TABLE "Answers" (
    "QuestionId" bigint NOT NULL,
    "HtmlContent" citext NOT NULL,
    "DisplayIndex" integer NOT NULL,
    "IsCorrected" boolean NOT NULL,
    "Score" double precision NOT NULL,
    "IsFixed" boolean NOT NULL,
    "Note" citext,
    "Deleted" boolean NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Asnwers" PRIMARY KEY ("Id")
);

CREATE TABLE "AttendanceGroupMembers" (
    "Id" bigint NOT NULL,
    "GroupId" bigint,
    "StudentId" bigint NOT NULL,
    "FaceSynced" boolean NOT NULL,
    "SyncedAt" timestamp,
    CONSTRAINT "PK_AttendanceGroupMembers" PRIMARY KEY ("Id")
);

CREATE TABLE "AttendanceGroups" (
    "Id" bigint NOT NULL,
    "GroupId" varchar(128) NOT NULL,
    "GroupType" citext NOT NULL,
    "Name" citext NOT NULL,
    "Module" citext NOT NULL,
    "Metadata" text,
    "IsActive" boolean NOT NULL,
    "CreatedAt" timestamp NOT NULL,
    "UpdatedAt" timestamp,
    CONSTRAINT "PK_AttendanceGroups" PRIMARY KEY ("Id")
);

CREATE TABLE "AttendanceResults" (
    "Id" bigint NOT NULL,
    "SessionId" varchar(64) NOT NULL,
    "GroupId" bigint NOT NULL,
    "StudentId" bigint,
    "OpaqueData" text,
    "FaceToken" text,
    "Status" citext NOT NULL,
    "VerifiedAt" timestamp,
    "IpAddress" varchar(64),
    CONSTRAINT "PK_AttendanceResults" PRIMARY KEY ("Id")
);

CREATE TABLE "Attendances" (
    "ClassId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "Note" citext,
    "Students" integer NOT NULL,
    "YearPart" integer NOT NULL,
    "LessonIndex" integer NOT NULL,
    "Status" integer NOT NULL,
    "AttDate" timestamp NOT NULL,
    "FinishTime" timestamp,
    "Id" bigint NOT NULL,
    "ServerId" citext,
    "StaffId" bigint,
    "AttData" text,
    CONSTRAINT "PK_Attendances" PRIMARY KEY ("Id")
);

CREATE TABLE "AttendanceSessions" (
    "Id" bigint NOT NULL,
    "SessionId" varchar(64) NOT NULL,
    "GroupId" bigint NOT NULL,
    "Module" citext NOT NULL,
    "CreatedAt" timestamp NOT NULL,
    "ExpireAt" timestamp NOT NULL,
    "IsActive" boolean NOT NULL,
    "CreatedBy" varchar(128),
    CONSTRAINT "PK_AttendanceSessions" PRIMARY KEY ("Id")
);

CREATE TABLE "BonusPointHistories" (
    "Id" bigint NOT NULL,
    "ClassSubjectId" bigint NOT NULL,
    "StudentId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "TargetField" citext NOT NULL,
    "SourceType" smallint NOT NULL,
    "SourceId" bigint,
    "BatchCode" varchar(50),
    "Delta" double precision NOT NULL,
    "Note" citext,
    "RuleDetails" text,
    "CreatedBy" bigint NOT NULL,
    "CreatedAt" timestamp NOT NULL,
    "IsDeleted" boolean NOT NULL,
    "DeletedAt" timestamp,
    "DeletedBy" bigint,
    CONSTRAINT "PK_BonusPointHistories" PRIMARY KEY ("Id")
);

CREATE TABLE "CalendarEventAttendees" (
    "Id" bigint NOT NULL,
    "CalendarEventId" bigint NOT NULL,
    "AttendeeId" bigint NOT NULL,
    "RoleType" smallint NOT NULL,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_CalendarEventAttendees" PRIMARY KEY ("Id")
);

CREATE TABLE "CalendarEvents" (
    "AttendanceId" bigint NOT NULL,
    "EventName" varchar(50) NOT NULL,
    "EventType" smallint NOT NULL,
    "Data" citext,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    "StartDate" timestamp,
    "FinishedDate" timestamp,
    "Duration" double precision,
    "Status" smallint NOT NULL,
    "StaffId" bigint,
    "ClassId" bigint NOT NULL,
    CONSTRAINT "PK_CalendarEvents" PRIMARY KEY ("Id")
);

CREATE TABLE "CandidateAnswers" (
    "CandidateId" bigint NOT NULL,
    "QuestionId" bigint NOT NULL,
    "Answers" citext,
    "Score" double precision NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_CandidateAnswers" PRIMARY KEY ("Id")
);

CREATE TABLE "CandidateCloScores" (
    "Id" bigint NOT NULL,
    "CloCode" citext NOT NULL,
    "CandidateId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "SetId" bigint NOT NULL,
    "Score" double precision NOT NULL,
    CONSTRAINT "PK__Candidat__3214EC078677BCF1" PRIMARY KEY ("Id")
);

CREATE TABLE "CandidateCommands" (
    "Cmd" smallint NOT NULL,
    "Data" citext NOT NULL,
    "CandidateId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_CandidateCommands" PRIMARY KEY ("Id")
);

CREATE TABLE "CandidateEvents" (
    "EventDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    "CandidateId" bigint NOT NULL,
    "EventType" smallint NOT NULL,
    "EventData" varchar(500),
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_CandidateEvents" PRIMARY KEY ("Id")
);

CREATE TABLE "CandidateGroups" (
    "Id" bigint NOT NULL,
    "GroupName" varchar(50),
    "ClassName" citext,
    "ExamSubjectId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_CandidateGroups" PRIMARY KEY ("Id")
);

CREATE TABLE "CandidateHistory" (
    "CandidateId" bigint NOT NULL,
    "TestId" bigint NOT NULL,
    "ChoiseCount" integer NOT NULL,
    "EssayCount" integer NOT NULL,
    "ChoiseScore" double precision NOT NULL,
    "EssayScore" double precision NOT NULL,
    "NegativeScore" double precision NOT NULL,
    "TotalScore" double precision NOT NULL,
    "Passed" boolean NOT NULL,
    "TotalTime" double precision NOT NULL,
    "StartTime" timestamp,
    "EndTime" timestamp,
    "YearPart" integer NOT NULL,
    "PenaltyId" bigint NOT NULL,
    "EntryTime" integer NOT NULL,
    "AnswerContent" text,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_CandidateHistory" PRIMARY KEY ("Id")
);

CREATE TABLE "CandidateOtherInfo" (
    "CandidateId" bigint NOT NULL,
    "AssignDevice" varchar(150),
    "IpAddress" varchar(150),
    "UseDevice" varchar(150),
    "TotalTime" double precision NOT NULL,
    "StartTime" timestamp,
    "EndTime" timestamp,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_CandidateOtherInfo" PRIMARY KEY ("CandidateId")
);

CREATE TABLE "CandidatePaperDetails" (
    "CandidateId" bigint NOT NULL,
    "PaperContent" text,
    "CreateDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_TestPaperDetails" PRIMARY KEY ("Id")
);

CREATE TABLE "CandidatePapers" (
    "CandidateId" bigint NOT NULL,
    "PaperContent" text,
    "LastUpdate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_TestPapers" PRIMARY KEY ("CandidateId")
);

CREATE TABLE "CandidatePartScores" (
    "CandidateId" bigint NOT NULL,
    "PartId" bigint NOT NULL,
    "ChoiseCount" integer NOT NULL,
    "EssayCount" integer NOT NULL,
    "ChoiseScore" double precision NOT NULL,
    "EssayScore" double precision NOT NULL,
    "TotalScore" double precision NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_CandidatePartScores" PRIMARY KEY ("Id")
);

CREATE TABLE "Candidates" (
    "StudentId" bigint NOT NULL,
    "ExamSubjectId" bigint NOT NULL,
    "RoomId" bigint NOT NULL,
    "SlotId" bigint NOT NULL,
    "TestId" bigint NOT NULL,
    "RoomNumber" integer NOT NULL,
    "MixNumber" integer NOT NULL,
    "ChoiseCount" integer NOT NULL,
    "EssayCount" integer NOT NULL,
    "ChoiseScore" double precision NOT NULL,
    "EssayScore" double precision NOT NULL,
    "NegativeScore" double precision NOT NULL,
    "TotalScore" double precision NOT NULL,
    "Status" smallint NOT NULL,
    "Passed" boolean NOT NULL,
    "Verified" boolean NOT NULL,
    "YearPart" integer NOT NULL,
    "PenaltyId" bigint NOT NULL,
    "ClassName" citext,
    "Note" citext,
    "GroupId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Candidates" PRIMARY KEY ("Id")
);

CREATE TABLE "CandidateVerification" (
    "CandidateId" bigint NOT NULL,
    "VerifiedDate" timestamp NOT NULL,
    "VerifiedType" smallint NOT NULL,
    "YearPart" integer NOT NULL,
    "VerifyData" varchar(500),
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_CandidateVerification" PRIMARY KEY ("Id")
);

CREATE TABLE "ChatBoxes" (
    "BoxId" varchar(30) NOT NULL,
    "YearPart" integer NOT NULL,
    "LastDate" timestamp NOT NULL,
    "LastMsgId" bigint NOT NULL,
    CONSTRAINT "PK__ChatBoxe__136CF7646B88AD46" PRIMARY KEY ("BoxId")
);

CREATE TABLE "ChatBoxMembers" (
    "BoxId" varchar(30),
    "UserId" bigint NOT NULL,
    "Status" smallint NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_ChatBoxMembers" PRIMARY KEY ("Id")
);

CREATE TABLE "ChatMessages" (
    "BoxId" varchar(30),
    "SenderId" bigint NOT NULL,
    "Content" citext,
    "SentDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    "ContentType" smallint NOT NULL,
    "ParentId" bigint NOT NULL,
    "Deleted" boolean NOT NULL,
    "ChatId" bigint NOT NULL,
    CONSTRAINT "PK__ChatMess__A9FBE7C6CEF6A110" PRIMARY KEY ("ChatId")
);

CREATE TABLE "ChatUserMessages" (
    "MessageId" bigint NOT NULL,
    "UserId" bigint NOT NULL,
    "Emotion" smallint NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK__ChatUser__3214EC07CD992F8E" PRIMARY KEY ("Id")
);

CREATE TABLE "ClassActivities" (
    "Name" citext,
    "Note" citext,
    "ContentType" smallint NOT NULL,
    "ContentId" bigint NOT NULL,
    "ShareType" smallint NOT NULL,
    "ClassId" bigint NOT NULL,
    "LessonId" bigint NOT NULL,
    "FileType" citext,
    "Status" smallint NOT NULL,
    "Settings" citext,
    "YearPart" integer NOT NULL,
    "DisplayIndex" integer NOT NULL,
    "StudentCount" integer NOT NULL,
    "DeadLine" timestamp,
    "StartDate" timestamp,
    "Id" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    CONSTRAINT "PK_ClassActivities" PRIMARY KEY ("Id")
);

CREATE TABLE "Classes" (
    "Code" citext,
    "Name" citext,
    "Note" citext,
    "Status" smallint NOT NULL,
    "CourseId" bigint NOT NULL,
    "StartYear" integer NOT NULL,
    "TypeId" bigint NOT NULL,
    "LevelId" bigint NOT NULL,
    "MajorId" bigint NOT NULL,
    "DepartmentId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Classes" PRIMARY KEY ("Id")
);

CREATE TABLE "ClassLessons" (
    "Name" citext,
    "LessonIndex" integer NOT NULL,
    "Note" citext,
    "ClassId" bigint NOT NULL,
    "Status" smallint NOT NULL,
    "YearPart" integer NOT NULL,
    "AllowComments" boolean NOT NULL,
    "CommentCount" integer NOT NULL,
    "LikeCount" integer NOT NULL,
    "DisLikeCount" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_ClassLessons" PRIMARY KEY ("Id")
);

CREATE TABLE "ClassManagers" (
    "StaffId" bigint NOT NULL,
    "ClassId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_ClassManagers" PRIMARY KEY ("Id")
);

CREATE TABLE "ClassPostAttachments" (
    "Id" bigint NOT NULL,
    "PostId" bigint NOT NULL,
    "FileName" varchar(400) NOT NULL,
    "StoredPath" varchar(1000) NOT NULL,
    "ContentType" citext,
    "SizeBytes" bigint,
    "IsImage" boolean NOT NULL,
    "Width" integer,
    "Height" integer,
    "CreateDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_ClassPostAttachments" PRIMARY KEY ("Id")
);

CREATE TABLE "ClassPostComments" (
    "Id" bigint NOT NULL,
    "PostId" bigint NOT NULL,
    "ParentId" bigint,
    "UserId" bigint NOT NULL,
    "Content" citext,
    "CreateDate" timestamp NOT NULL,
    "EditedDate" timestamp,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_ClassPostComments" PRIMARY KEY ("Id")
);

CREATE TABLE "ClassPostLinks" (
    "Id" bigint NOT NULL,
    "PostId" bigint NOT NULL,
    "Url" citext NOT NULL,
    "Title" citext,
    "Description" varchar(1000),
    "ImageUrl" varchar(1000),
    "CreateDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_ClassPostLinks" PRIMARY KEY ("Id")
);

CREATE TABLE "ClassPosts" (
    "Content" citext,
    "CreateDate" timestamp NOT NULL,
    "ClassId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "UserId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    "EditedDate" timestamp,
    "IsPinned" boolean NOT NULL,
    CONSTRAINT "PK_ClassPosts" PRIMARY KEY ("Id")
);

CREATE TABLE "ClassPostViews" (
    "Id" bigint NOT NULL,
    "PostId" bigint NOT NULL,
    "UserId" bigint NOT NULL,
    "ViewDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_ClassPostViews" PRIMARY KEY ("Id")
);

CREATE TABLE "ClassReactions" (
    "Id" bigint NOT NULL,
    "TargetType" smallint NOT NULL,
    "TargetId" bigint NOT NULL,
    "UserId" bigint NOT NULL,
    "ReactionType" smallint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_ClassReactions" PRIMARY KEY ("Id")
);

CREATE TABLE "ClassStudentGroups" (
    "GroupName" varchar(50),
    "ClassId" bigint NOT NULL,
    "Actived" boolean NOT NULL,
    "MemberIds" varchar(500),
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_ClassGroups" PRIMARY KEY ("Id")
);

CREATE TABLE "ClassStudents" (
    "ClassId" bigint NOT NULL,
    "StudentId" bigint NOT NULL,
    "Score" double precision NOT NULL,
    "Note" citext,
    "YearPart" integer NOT NULL,
    "GroupId" bigint,
    "Bonus" double precision NOT NULL,
    "Attendances" double precision NOT NULL,
    "Id" bigint NOT NULL,
    "AttendanceBonus" double precision NOT NULL,
    CONSTRAINT "PK_ClassStudents" PRIMARY KEY ("Id")
);

CREATE TABLE "ClassSubjectData" (
    "YearPart" integer NOT NULL,
    "DataKey" citext NOT NULL,
    "ClassId" bigint NOT NULL,
    "DataValue" citext,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_ClassSubjectData" PRIMARY KEY ("Id")
);

CREATE TABLE "ClassSubjects" (
    "Name" citext,
    "Status" smallint NOT NULL,
    "SubjectId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    "YearId" bigint NOT NULL,
    "Term" integer NOT NULL,
    "CreatorId" bigint NOT NULL,
    "ServerId" citext,
    "StudentCount" integer NOT NULL,
    "Type" smallint NOT NULL,
    "MaxUsedTest" integer NOT NULL,
    "UseExams" varchar(500),
    "StudyType" smallint NOT NULL,
    "RegisterType" smallint NOT NULL,
    "Logo" varchar(500),
    "StartDate" date,
    "FinishDate" date,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_SubjectClass" PRIMARY KEY ("Id")
);

CREATE TABLE "CloScoreTypes" (
    "ScoreTypeId" bigint NOT NULL,
    "CloCode" citext NOT NULL,
    "SubjectId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_CloScoreTypes" PRIMARY KEY ("Id")
);

CREATE TABLE "ConductScores" (
    "Id" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "YearId" bigint NOT NULL,
    "Term" smallint NOT NULL,
    "StudentId" bigint NOT NULL,
    "Score" numeric(6, 3) NOT NULL,
    "Note" citext,
    "CreateAt" timestamp NOT NULL,
    "CreateBy" bigint NOT NULL,
    CONSTRAINT "PK_ConductScores" PRIMARY KEY ("Id", "YearPart")
);

CREATE TABLE "Configs" (
    "ConfigKey" citext NOT NULL,
    "DisplayName" varchar(50),
    "ConfigValue" citext,
    "GroupName" varchar(50),
    "DisplayIndex" integer NOT NULL,
    "ColumnCount" integer,
    "FormGroup" varchar(50),
    "Editor" varchar(150),
    CONSTRAINT "PK_Configs" PRIMARY KEY ("ConfigKey")
);

CREATE TABLE "CourseLearningOutcomes" (
    "SetId" bigint NOT NULL,
    "Code" citext,
    "Note" citext,
    "OrderIndex" integer NOT NULL,
    "Weight" double precision NOT NULL,
    "ParentId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    "PassScore" double precision DEFAULT 60,
    CONSTRAINT "PK_CourseLearningOutcomes1" PRIMARY KEY ("Id")
);

CREATE TABLE "CourseLearningOutcomeSets" (
    "Name" citext,
    "Note" citext,
    "SubjectId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "StaffId" bigint NOT NULL,
    "Status" smallint NOT NULL,
    "YearId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_CourseLearningOutcomes" PRIMARY KEY ("Id")
);

CREATE TABLE "Courses" (
    "Name" citext NOT NULL,
    "Note" citext,
    "Status" smallint NOT NULL,
    "DepartmentId" bigint NOT NULL,
    "YearId" bigint NOT NULL,
    "Code" citext,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Courses" PRIMARY KEY ("Id")
);

CREATE TABLE "Departments" (
    "ParentId" bigint NOT NULL,
    "Code" citext,
    "Name" citext,
    "Note" citext,
    "DisplayIndex" integer NOT NULL,
    "Type" smallint NOT NULL,
    "Id" bigint NOT NULL,
    "NameEn" varchar(200),
    CONSTRAINT "PK_Departments" PRIMARY KEY ("Id")
);

CREATE TABLE "Devices" (
    "Id" varchar(50) NOT NULL,
    "Name" citext,
    "Type" citext,
    "Browser" varchar(50),
    "Ip" varchar(50),
    "CreateDate" timestamp,
    "UserAgent" varchar(1000),
    "RefUrl" varchar(1000),
    "RefType" smallint NOT NULL,
    CONSTRAINT "PK_Devices" PRIMARY KEY ("Id")
);

CREATE TABLE "DocumentContents" (
    "ThumbImage" varchar(500),
    "DataContent" citext,
    "ContentType" smallint NOT NULL,
    "DocumentId" bigint NOT NULL,
    "Title" citext,
    "Comments" text,
    "Audio" varchar(500),
    "DisplayIndex" integer NOT NULL,
    "Timeline" double precision NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_DocumentContents" PRIMARY KEY ("Id")
);

CREATE TABLE "Documents" (
    "FileType" citext,
    "FileName" varchar(400),
    "FilePath" varchar(500),
    "ContentType" smallint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "StaffId" bigint NOT NULL,
    "DepartmentId" bigint NOT NULL,
    "SubjectId" bigint NOT NULL,
    "ShareType" smallint NOT NULL,
    "MasterData" text,
    "FolderId" bigint,
    "UpdateDate" timestamp,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Documents" PRIMARY KEY ("Id")
);

CREATE TABLE "Emails" (
    "Title" citext,
    "Receiver" varchar(500),
    "CC" varchar(500),
    "Body" text,
    "Attachments" text,
    "SentDate" timestamp NOT NULL,
    "Status" smallint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Emails" PRIMARY KEY ("Id")
);

CREATE TABLE "ExamChatMessages" (
    "Id" bigint NOT NULL,
    "ExamSubjectId" bigint NOT NULL,
    "SlotId" bigint,
    "RoomId" bigint,
    "YearPart" integer NOT NULL,
    "MessageType" smallint DEFAULT 0 NOT NULL,
    "SenderId" citext NOT NULL,
    "SenderName" varchar(200),
    "IsAdmin" boolean DEFAULT false NOT NULL,
    "ReceiverId" citext,
    "Message" citext NOT NULL,
    "CreatedTime" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "UnixTime" bigint NOT NULL,
    "Viewed" boolean DEFAULT false NOT NULL,
    CONSTRAINT "PK__ExamChat__3214EC078DCCF689" PRIMARY KEY ("Id")
);

CREATE TABLE "ExamManagers" (
    "StaffId" bigint NOT NULL,
    "ExamId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    "ManageAll" boolean DEFAULT true NOT NULL,
    CONSTRAINT "PK_ExamManagers" PRIMARY KEY ("Id")
);

CREATE TABLE "ExamPenalty" (
    "Id" bigint NOT NULL,
    "Name" citext NOT NULL,
    "Penalty" double precision NOT NULL,
    "Suspend" boolean NOT NULL,
    "Message" citext,
    CONSTRAINT "PK_ExamPenalty" PRIMARY KEY ("Id")
);

CREATE TABLE "ExamRooms" (
    "RoomCode" citext NOT NULL,
    "RoomName" citext NOT NULL,
    "Place" citext,
    "Capacity" integer NOT NULL,
    "Hidden" boolean NOT NULL,
    "Id" bigint NOT NULL,
    "NetworkId" bigint,
    "GridRows" integer DEFAULT 0 NOT NULL,
    "GridCols" integer DEFAULT 0 NOT NULL,
    CONSTRAINT "PK_TestRooms" PRIMARY KEY ("Id")
);

CREATE TABLE "Exams" (
    "Name" citext NOT NULL,
    "Note" citext,
    "Term" integer NOT NULL,
    "DepartmentId" bigint NOT NULL,
    "CreatorId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "Status" smallint NOT NULL,
    "YearId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "ClassId" bigint,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Exams" PRIMARY KEY ("Id")
);

CREATE TABLE "ExamSchedules" (
    "ExamSubjectId" bigint NOT NULL,
    "SlotId" bigint NOT NULL,
    "RoomId" bigint NOT NULL,
    "Status" smallint NOT NULL,
    "RoomData" varchar(2000),
    "StartDate" timestamp,
    "StopDate" timestamp,
    "YearPart" integer NOT NULL,
    "Password" citext,
    "Title" citext,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_ExamSchedules" PRIMARY KEY ("Id")
);

CREATE TABLE "ExamSlots" (
    "SlotName" varchar(50) NOT NULL,
    "SlotDate" date NOT NULL,
    "SlotTime" integer NOT NULL,
    "ExamId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_TestSlots" PRIMARY KEY ("Id")
);

CREATE TABLE "ExamSubjectAssignments" (
    "Id" bigint NOT NULL,
    "ExamSubjectId" bigint NOT NULL,
    "StaffId" bigint,
    "QuestionBankId" bigint,
    "CreatorId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "AssignNote" varchar(1000),
    "Status" smallint DEFAULT 0 NOT NULL,
    "TestGeneratorId" bigint,
    "TeacherApprovedDate" timestamp,
    "HeadApprovedDate" timestamp,
    "YearPart" integer NOT NULL,
    "HeadApproverStaffId" bigint,
    CONSTRAINT "PK_ExamSubjectAssignments" PRIMARY KEY ("Id")
);

CREATE TABLE "ExamSubjectAssignmentTestGenerators" (
    "Id" bigint NOT NULL,
    "ExamSubjectAssignmentId" bigint NOT NULL,
    "TestGeneratorId" bigint NOT NULL,
    "Status" smallint DEFAULT 0 NOT NULL,
    "TeacherApprovedDate" timestamp,
    "HeadApprovedDate" timestamp,
    "HeadApproverStaffId" bigint,
    "CreateDate" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "CreatorId" bigint,
    "Note" citext,
    CONSTRAINT "PK_ESATG" PRIMARY KEY ("Id")
);

CREATE TABLE "ExamSubjectClos" (
    "Id" bigint NOT NULL,
    "ExamSubjectId" bigint NOT NULL,
    "SetId" bigint NOT NULL,
    "CloCode" citext NOT NULL,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_ExamSubjectClos" PRIMARY KEY ("Id")
);

CREATE TABLE "ExamSubjectInfo" (
    "ExamSubjectId" bigint NOT NULL,
    "Code" citext NOT NULL,
    "DataValue" citext,
    "RoomId" bigint NOT NULL,
    "SlotId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_ExamSubjectInfo" PRIMARY KEY ("Id")
);

CREATE TABLE "ExamSubjectManagers" (
    "ExamSubjectId" bigint NOT NULL,
    "StaffId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_ExamSubjectManagers" PRIMARY KEY ("Id")
);

CREATE TABLE "ExamSubjectNetworks" (
    "ExamSubjectId" bigint NOT NULL,
    "NetworkId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "RoomId" bigint,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_ExamSubjectNetworks" PRIMARY KEY ("Id")
);

CREATE TABLE "ExamSubjects" (
    "Title" citext,
    "Note" citext,
    "SubjectId" bigint NOT NULL,
    "StudentCount" integer NOT NULL,
    "TestCount" integer NOT NULL,
    "StartDate" timestamp NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "ExamId" bigint NOT NULL,
    "Status" smallint NOT NULL,
    "SentEmails" integer NOT NULL,
    "CreatorId" bigint NOT NULL,
    "DepartmentId" bigint NOT NULL,
    "SubjectData" varchar(1500),
    "LevelId" bigint NOT NULL,
    "CourseId" bigint NOT NULL,
    "MajorId" bigint NOT NULL,
    "EntryCount" integer NOT NULL,
    "CanRegister" boolean NOT NULL,
    "MaxScore" double precision NOT NULL,
    "PassScore" double precision NOT NULL,
    "RequiredFullScreen" boolean NOT NULL,
    "CheckScreen" boolean NOT NULL,
    "ViewScreen" boolean NOT NULL,
    "CheckFace" smallint,
    "ViewCamera" boolean NOT NULL,
    "RequiredAudio" boolean NOT NULL,
    "LateTime" integer NOT NULL,
    "ViewScore" smallint NOT NULL,
    "LostFocus" integer NOT NULL,
    "ShowChat" boolean NOT NULL,
    "TestType" smallint NOT NULL,
    "StartTime" timestamp,
    "FinishTime" timestamp,
    "PrintDate" timestamp,
    "YearPart" integer NOT NULL,
    "SlotCount" integer NOT NULL,
    "TestCreated" integer NOT NULL,
    "PrintManager" varchar(500),
    "PrintTime" varchar(500),
    "RoundRule" smallint NOT NULL,
    "RoundDigit" smallint NOT NULL,
    "LevelOrder" integer NOT NULL,
    "TimeMode" integer NOT NULL,
    "PreferTimeType" smallint NOT NULL,
    "SurveyId" bigint NOT NULL,
    "SurveyMode" smallint NOT NULL,
    "Id" bigint NOT NULL,
    "HasEssay" boolean NOT NULL,
    CONSTRAINT "PK_TestSchedules" PRIMARY KEY ("Id")
);

CREATE TABLE "ExamSupervisors" (
    "ExamScheduleId" bigint NOT NULL,
    "StaffId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_ExamSupervisors" PRIMARY KEY ("Id")
);

CREATE TABLE "Faces" (
    "OwnerId" bigint NOT NULL,
    "OwnerType" smallint NOT NULL,
    "FaceData" text NOT NULL,
    "FaceFiles" varchar(2000),
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Faces" PRIMARY KEY ("Id")
);

CREATE TABLE "Fingers" (
    "Id" bigint NOT NULL,
    "OwnerType" smallint NOT NULL,
    "OwnerId" bigint NOT NULL,
    "Finger1" varchar(2000),
    "Finger2" varchar(2000),
    "Finger3" varchar(2000),
    "Finger4" varchar(2000),
    "Finger5" varchar(2000),
    CONSTRAINT "PK_Fingers_1" PRIMARY KEY ("Id")
);

CREATE TABLE "FileDownloadLogs" (
    "Id" bigint NOT NULL,
    "StudentId" bigint NOT NULL,
    "ActivityId" bigint NOT NULL,
    "ClassId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "FilePath" varchar(900),
    "FileName" varchar(400),
    "CreateDate" timestamp NOT NULL,
    CONSTRAINT "PK_FileDownloadLogs" PRIMARY KEY ("Id")
);

CREATE TABLE "Folders" (
    "FolderName" varchar(200),
    "ParentId" bigint NOT NULL,
    "StaffId" bigint NOT NULL,
    "DepartmentId" bigint NOT NULL,
    "SubjectId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Folders" PRIMARY KEY ("Id")
);

CREATE TABLE "Helps" (
    "Title" citext,
    "HelpContent" text,
    "Controller" citext,
    "Action" citext,
    "ParentId" bigint NOT NULL,
    "Language" citext,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Helps" PRIMARY KEY ("Id")
);

CREATE TABLE "LearningJournalCommentAttachments" (
    "Id" bigint NOT NULL,
    "CommentId" bigint NOT NULL,
    "AttachmentType" smallint NOT NULL,
    "FileUrl" varchar(1000),
    "FileName" varchar(255),
    "MimeType" varchar(100),
    "FileSize" bigint,
    "ThumbUrl" varchar(1000),
    "ExternalUrl" varchar(1000),
    "Caption" varchar(500),
    "UploaderId" bigint NOT NULL,
    "UploadDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_LearningJournalCommentAttachments" PRIMARY KEY ("Id")
);

CREATE TABLE "LearningJournalCommentMentions" (
    "Id" bigint NOT NULL,
    "CommentId" bigint NOT NULL,
    "MentionedUserId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_LearningJournalCommentMentions" PRIMARY KEY ("Id")
);

CREATE TABLE "LearningJournalCommentReactions" (
    "Id" bigint NOT NULL,
    "CommentId" bigint NOT NULL,
    "ReactionType" smallint NOT NULL,
    "UserId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_LearningJournalCommentReactions" PRIMARY KEY ("Id")
);

CREATE TABLE "LearningJournalComments" (
    "Id" bigint NOT NULL,
    "EntryId" bigint NOT NULL,
    "ParentCommentId" bigint,
    "RootCommentId" bigint,
    "Depth" smallint NOT NULL,
    "Content" citext NOT NULL,
    "ContentFormat" smallint NOT NULL,
    "IsPinned" boolean NOT NULL,
    "CreatedByUserId" bigint NOT NULL,
    "CreatedByRole" smallint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "LastEditedByUserId" bigint,
    "LastEditedAt" timestamp,
    "IsDeleted" boolean NOT NULL,
    "DeletedByUserId" bigint,
    "DeletedAt" timestamp,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_LearningJournalComments" PRIMARY KEY ("Id")
);

CREATE TABLE "LearningJournalEntries" (
    "Id" bigint NOT NULL,
    "ClassSubjectId" bigint NOT NULL,
    "SubjectId" bigint NOT NULL,
    "StudentId" bigint NOT NULL,
    "TypeId" bigint NOT NULL,
    "Title" citext NOT NULL,
    "Content" citext,
    "OccurredAt" timestamp,
    "Visibility" smallint NOT NULL,
    "SourceType" smallint NOT NULL,
    "Status" smallint NOT NULL,
    "CreatedByUserId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "LastUpdate" timestamp,
    "SubmittedAt" timestamp,
    "ReviewedAt" timestamp,
    "ReviewedByUserId" bigint,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_LearningJournalEntries" PRIMARY KEY ("Id")
);

CREATE TABLE "LearningJournalEvidences" (
    "Id" bigint NOT NULL,
    "EntryId" bigint NOT NULL,
    "EvidenceType" smallint NOT NULL,
    "FileUrl" varchar(1000),
    "FileName" varchar(255),
    "MimeType" varchar(100),
    "FileSize" bigint,
    "ThumbUrl" varchar(1000),
    "ExternalUrl" varchar(1000),
    "Caption" varchar(500),
    "UploaderId" bigint NOT NULL,
    "UploadDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_LearningJournalEvidences" PRIMARY KEY ("Id")
);

CREATE TABLE "LearningJournalReviews" (
    "Id" bigint NOT NULL,
    "EntryId" bigint NOT NULL,
    "Action" smallint NOT NULL,
    "Comment" varchar(2000),
    "CreatedByUserId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    CONSTRAINT "PK_LearningJournalReviews" PRIMARY KEY ("Id")
);

CREATE TABLE "LearningJournalTypes" (
    "Id" bigint NOT NULL,
    "Scope" smallint NOT NULL,
    "SubjectId" bigint,
    "ClassSubjectId" bigint,
    "ParentTypeId" bigint,
    "Code" citext,
    "Name" citext NOT NULL,
    "Description" varchar(1000),
    "Icon" varchar(50),
    "Color" citext,
    "SortOrder" integer DEFAULT 0 NOT NULL,
    "IsActive" boolean DEFAULT true NOT NULL,
    "IsRequiredEvidence" boolean DEFAULT false NOT NULL,
    "CreatorId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "LastUpdate" timestamp,
    "DefaultAllowedSourceType" smallint DEFAULT 2 NOT NULL,
    CONSTRAINT "PK_LearningJournalTypes" PRIMARY KEY ("Id")
);

CREATE TABLE "LearningJournalTypeSettings" (
    "Id" bigint NOT NULL,
    "ClassSubjectId" bigint NOT NULL,
    "TypeId" bigint NOT NULL,
    "IsEnabled" boolean DEFAULT true NOT NULL,
    "SortOrder" integer DEFAULT 0 NOT NULL,
    "Note" citext,
    "CreatorId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    "AllowedSourceType" smallint NOT NULL,
    CONSTRAINT "PK_LearningJournalTypeSettings" PRIMARY KEY ("Id")
);

CREATE TABLE "LessonComments" (
    "ClassId" bigint NOT NULL,
    "LessonId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "UserId" bigint NOT NULL,
    "Comment" varchar(2000),
    "CreateDate" timestamp NOT NULL,
    "ParentId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_LessonComments" PRIMARY KEY ("Id")
);

CREATE TABLE "LessonEmotions" (
    "UserId" bigint,
    "Action" smallint NOT NULL,
    "LessonId" bigint NOT NULL,
    "ClassId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_LessonEmotions" PRIMARY KEY ("Id")
);

CREATE TABLE "Levels" (
    "Name" citext NOT NULL,
    "Note" citext,
    "Status" smallint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Levels" PRIMARY KEY ("Id")
);

CREATE TABLE "Logs" (
    "LogContent" citext NOT NULL,
    "Action" citext NOT NULL,
    "Feature" citext NOT NULL,
    "UserId" bigint NOT NULL,
    "StaffName" citext NOT NULL,
    "LogDate" timestamp NOT NULL,
    "Tags" citext,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Logs" PRIMARY KEY ("Id")
);

CREATE TABLE "Majors" (
    "Code" citext NOT NULL,
    "Name" citext,
    "Note" citext,
    "DepartmentId" bigint NOT NULL,
    "Status" smallint NOT NULL,
    "MaxTime" integer NOT NULL,
    "TimeType" smallint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Majors" PRIMARY KEY ("Id")
);

CREATE TABLE "MarkDetails" (
    "MarkId" bigint NOT NULL,
    "StaffId" bigint NOT NULL,
    "Marks" integer NOT NULL,
    "Remarks" integer NOT NULL,
    "StartDate" timestamp NOT NULL,
    "EndDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_MarkDetails" PRIMARY KEY ("Id")
);

CREATE TABLE "MarkManagers" (
    "StaffId" bigint NOT NULL,
    "MarkId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_MarkManagers" PRIMARY KEY ("Id")
);

CREATE TABLE "MarkPaperDetails" (
    "MarkPaperId" bigint NOT NULL,
    "CandidateId" bigint NOT NULL,
    "QuestionId" bigint NOT NULL,
    "Score" double precision NOT NULL,
    "AnswerId" bigint NOT NULL,
    "Note" citext,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_MarkPaperDetails" PRIMARY KEY ("Id")
);

CREATE TABLE "MarkPapers" (
    "StaffId" bigint NOT NULL,
    "CandidateId" bigint NOT NULL,
    "Score" double precision NOT NULL,
    "Note" citext,
    "MarkDate" timestamp,
    "YearPart" integer NOT NULL,
    "MarkId" bigint NOT NULL,
    "MarkIndex" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_MarkPapers" PRIMARY KEY ("Id")
);

CREATE TABLE "MarkRooms" (
    "ExamSubjectId" bigint NOT NULL,
    "RoomId" bigint NOT NULL,
    "SlotId" bigint NOT NULL,
    "ImagePath" varchar(500),
    "SheetData" text,
    "Page" integer NOT NULL,
    "StartIndex" integer NOT NULL,
    "EndIndex" integer NOT NULL,
    "StaffId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "SaveDate" timestamp,
    "MarkId" bigint NOT NULL,
    "PaperCount" integer NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_MarkRooms" PRIMARY KEY ("Id")
);

CREATE TABLE "Marks" (
    "Name" citext,
    "CreateDate" timestamp NOT NULL,
    "YearPart" integer NOT NULL,
    "ExamSubjectId" bigint NOT NULL,
    "ManagerId" bigint NOT NULL,
    "StartDate" timestamp NOT NULL,
    "EndDate" timestamp NOT NULL,
    "CreateUserId" bigint NOT NULL,
    "Status" smallint NOT NULL,
    "Remark" boolean NOT NULL,
    "AssignMode" smallint NOT NULL,
    "AllowViewStudent" smallint NOT NULL,
    "AllowViewOtherScore" smallint NOT NULL,
    "StudentCount" integer NOT NULL,
    "OneMarker" boolean NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Marks" PRIMARY KEY ("Id")
);

CREATE TABLE "MarkSlots" (
    "MarkId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "SlotId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_MarkSlots" PRIMARY KEY ("Id")
);

CREATE TABLE "Networks" (
    "Name" citext NOT NULL,
    "IpAddresses" citext,
    "Actived" boolean NOT NULL,
    "Default" boolean NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Networks" PRIMARY KEY ("Id")
);

CREATE TABLE "NotificationDevices" (
    "UserId" bigint NOT NULL,
    "DeviceId" varchar(200),
    "Token" citext,
    "DeviceType" smallint NOT NULL,
    "LastAccess" timestamp,
    "Status" smallint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK__Notifica__3214EC075590485C" PRIMARY KEY ("Id")
);

CREATE TABLE "Organizations" (
    "Name" citext NOT NULL,
    "Url" citext,
    "Logo" varchar(500),
    "Status" smallint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Organizations" PRIMARY KEY ("Id")
);

CREATE TABLE "OtherScores" (
    "Code" citext NOT NULL,
    "Term" integer NOT NULL,
    "YearId" bigint NOT NULL,
    "StudentId" bigint NOT NULL,
    "SubjectId" bigint NOT NULL,
    "Score" double precision NOT NULL,
    "ExamSubjectId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_OtherScores" PRIMARY KEY ("Id")
);

CREATE TABLE "OutcomeAssessments" (
    "Name" citext,
    "YearId" bigint NOT NULL,
    "ProgramId" bigint NOT NULL,
    "CourseId" bigint NOT NULL,
    "PassedCount" integer NOT NULL,
    "PassScore" double precision NOT NULL,
    "TotalCount" integer NOT NULL,
    "Status" smallint NOT NULL,
    "StaffId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "Note" citext,
    "YearPart" integer NOT NULL,
    "MajorId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_OutcomeAssements" PRIMARY KEY ("Id")
);

CREATE TABLE "OutcomeMappings" (
    "SubjectId" bigint NOT NULL,
    "PloCode" citext NOT NULL,
    "CloCode" citext NOT NULL,
    "Weight" double precision NOT NULL,
    "ProgramId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_OutcomeMappings" PRIMARY KEY ("Id")
);

CREATE TABLE "OutcomeStudents" (
    "AssessmentId" bigint NOT NULL,
    "StudentId" bigint NOT NULL,
    "IsPassed" integer NOT NULL,
    "YearPart" integer NOT NULL,
    "PassedCount" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_OutcomeStudents" PRIMARY KEY ("Id")
);

CREATE TABLE "Paragraphs" (
    "DocumentId" bigint NOT NULL,
    "OrderIndex" integer NOT NULL,
    "TextContent" text,
    "Encodings" bytea,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Paragraphs" PRIMARY KEY ("Id")
);

CREATE TABLE "Positions" (
    "Id" bigint NOT NULL,
    "Code" citext,
    "Name" citext NOT NULL,
    "RoleType" smallint DEFAULT 0 NOT NULL,
    "Category" varchar(50),
    "Note" citext,
    "IsActive" boolean DEFAULT true NOT NULL,
    "CreatedAt" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Positions" PRIMARY KEY ("Id")
);

CREATE TABLE "Posts" (
    "Title" citext NOT NULL,
    "Media" citext NOT NULL,
    "MediaType" smallint NOT NULL,
    "Content" citext,
    "CreateDate" timestamp NOT NULL,
    "PublishDate" timestamp DEFAULT NULL,
    "Status" smallint NOT NULL,
    "BranchId" bigint DEFAULT NULL,
    "ClassId" bigint NOT NULL,
    "UserCreateId" bigint NOT NULL,
    "Views" integer NOT NULL,
    "Comments" integer NOT NULL,
    "Likes" integer NOT NULL,
    "Dislikes" integer NOT NULL,
    "PostType" smallint NOT NULL,
    "Featured" boolean NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Posts" PRIMARY KEY ("Id")
);

CREATE TABLE "PostViews" (
    "Id" bigint NOT NULL,
    "PostId" bigint NOT NULL,
    "UserId" bigint NOT NULL,
    "ViewDate" timestamp NOT NULL,
    "SessionId" varchar(50) NOT NULL,
    CONSTRAINT "PK_PostViews" PRIMARY KEY ("Id")
);

CREATE TABLE "PracticeAnswers" (
    "Id" bigint NOT NULL,
    "SessionId" bigint NOT NULL,
    "QuestionId" bigint NOT NULL,
    "QuestionIndex" integer DEFAULT 0 NOT NULL,
    "StudentAnswer" text,
    "CorrectAnswer" text,
    "IsCorrect" boolean DEFAULT false NOT NULL,
    "Score" double precision DEFAULT 0 NOT NULL,
    "MaxScore" double precision DEFAULT 0 NOT NULL,
    "TimeSpent" double precision DEFAULT 0 NOT NULL,
    "AnsweredAt" timestamp,
    "QuestionType" integer DEFAULT 0 NOT NULL,
    CONSTRAINT "PK__Practice__3214EC07998E42CF" PRIMARY KEY ("Id")
);

CREATE TABLE "PracticeSessions" (
    "Id" bigint NOT NULL,
    "StudentId" bigint NOT NULL,
    "ActivityId" bigint NOT NULL,
    "ClassId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "SessionNumber" integer DEFAULT 1 NOT NULL,
    "TotalQuestions" integer DEFAULT 0 NOT NULL,
    "QuestionCount" integer DEFAULT 0 NOT NULL,
    "CorrectCount" integer DEFAULT 0 NOT NULL,
    "WrongCount" integer DEFAULT 0 NOT NULL,
    "AnsweredCount" integer DEFAULT 0 NOT NULL,
    "TotalScore" double precision DEFAULT 0 NOT NULL,
    "MaxScore" double precision DEFAULT 0 NOT NULL,
    "StartTime" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "EndTime" timestamp,
    "TimeSpent" double precision DEFAULT 0 NOT NULL,
    "Status" smallint DEFAULT 1 NOT NULL,
    "CreatedDate" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "ModifiedDate" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT "PK__Practice__3214EC07EABAB1A6" PRIMARY KEY ("Id")
);

CREATE TABLE "ProgramDetails" (
    "SubjectId" bigint NOT NULL,
    "ProgramId" bigint NOT NULL,
    "Year" integer NOT NULL,
    "Term" integer NOT NULL,
    "SubjectType" smallint NOT NULL,
    CONSTRAINT "PK_ProgramDetails_1" PRIMARY KEY ("SubjectId", "ProgramId")
);

CREATE TABLE "ProgramOutcomes" (
    "Code" citext,
    "Name" citext,
    "ProgramId" bigint NOT NULL,
    "ParentId" bigint NOT NULL,
    "PassScore" double precision NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_ProgramOutcomes" PRIMARY KEY ("Id")
);

CREATE TABLE "ProgramUsages" (
    "ProgramId" bigint NOT NULL,
    "CourseId" bigint NOT NULL,
    "ClassId" bigint NOT NULL,
    "MajorId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_ProgramUsages" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionAssignmentComments" (
    "Id" bigint NOT NULL,
    "AssignmentId" bigint NOT NULL,
    "QuestionAssignmentId" bigint,
    "ParentId" bigint,
    "UserId" bigint NOT NULL,
    "Content" citext NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "IsDeleted" boolean NOT NULL,
    "DeletedDate" timestamp,
    "UpdatedDate" timestamp,
    CONSTRAINT "PK_QuestionAssignmentComments" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionAssignmentReviewers" (
    "Id" bigint NOT NULL,
    "AssignmentId" bigint NOT NULL,
    "StaffId" bigint NOT NULL,
    "AddedDate" timestamp NOT NULL,
    "AddedById" bigint NOT NULL,
    "Status" smallint DEFAULT 0 NOT NULL,
    "ReviewDate" timestamp,
    "Comment" varchar(500),
    "DisplayOrder" integer DEFAULT 0 NOT NULL,
    "ProgressDone" integer DEFAULT 0 NOT NULL,
    "IsDisabled" boolean DEFAULT false NOT NULL,
    CONSTRAINT "PK_QuestionAssignmentReviewers" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionAssignmentReviews" (
    "Id" bigint NOT NULL,
    "AssignmentId" bigint NOT NULL,
    "QuestionAssignmentId" bigint,
    "ReviewerId" bigint NOT NULL,
    "ReviewDate" timestamp NOT NULL,
    "Action" smallint NOT NULL,
    "PreviousStatus" smallint NOT NULL,
    "NewStatus" smallint NOT NULL,
    "Comment" varchar(2000),
    "Round" integer DEFAULT 1 NOT NULL,
    CONSTRAINT "PK_QuestionAssignmentReviews" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionAssignments" (
    "Id" bigint NOT NULL,
    "QuestionId" bigint NOT NULL,
    "AssignmentId" bigint NOT NULL,
    "Note" citext,
    "Status" smallint NOT NULL,
    "TargetReplaceId" bigint,
    "EditDate" timestamp,
    "ReviewNote" varchar(1000),
    CONSTRAINT "PK_QuestionAssignments" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionAttachments" (
    "Id" bigint NOT NULL,
    "QuestionId" bigint NOT NULL,
    "FileName" varchar(500) NOT NULL,
    "StoredPath" varchar(500) NOT NULL,
    "ContentType" citext,
    "SizeBytes" bigint DEFAULT 0 NOT NULL,
    "CreateDate" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT "PK_QuestionAttachments" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionBankAssignments" (
    "Id" bigint NOT NULL,
    "StaffId" bigint NOT NULL,
    "QuestionBankId" bigint NOT NULL,
    "StartDate" timestamp NOT NULL,
    "EndDate" timestamp NOT NULL,
    "Status" smallint NOT NULL,
    "TaskType" smallint NOT NULL,
    "TaskNote" varchar(500),
    "StaffNote" varchar(500),
    "CreatorId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "ReviewRound" integer DEFAULT 1 NOT NULL,
    "ReviewerId" bigint,
    "SubmitDate" timestamp,
    "ReviewDate" timestamp,
    "CompletedDate" timestamp,
    "RequireAllReviewers" boolean NOT NULL,
    "ProgressTotal" integer DEFAULT 0 NOT NULL,
    "ProgressDone" integer DEFAULT 0 NOT NULL,
    CONSTRAINT "PK_QuestionBankAssignments" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionBankAssignmentStaffs" (
    "Id" bigint NOT NULL,
    "StaffId" bigint NOT NULL,
    "AssignmentId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    CONSTRAINT "PK_QuestionBankAssignmentStaffs" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionBankClo" (
    "LevelId" bigint NOT NULL,
    "SubjectDetailId" bigint NOT NULL,
    "QuestionBankId" bigint NOT NULL,
    "CloCode" citext NOT NULL,
    "Id" bigint NOT NULL,
    "Weight" double precision NOT NULL,
    "SetId" bigint NOT NULL,
    CONSTRAINT "PK_QuestionBankClo" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionBankDocuments" (
    "DocumentId" bigint NOT NULL,
    "QuestionBankId" bigint NOT NULL,
    "SubjectDetailId" bigint NOT NULL,
    "LevelId" bigint NOT NULL,
    "Type" smallint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_QuestionBankDocuments" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionBanks" (
    "Name" citext NOT NULL,
    "Note" citext,
    "SubjectId" bigint NOT NULL,
    "Levels" varchar(1000),
    "StaffId" bigint NOT NULL,
    "DepartmentId" bigint NOT NULL,
    "ViewPerm" smallint NOT NULL,
    "EditPerm" smallint NOT NULL,
    "BankType" smallint NOT NULL,
    "Status" smallint NOT NULL,
    "QuestionCount" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_QuestionBanks" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionBankShares" (
    "TargetId" bigint NOT NULL,
    "Permission" smallint NOT NULL,
    "TargetType" smallint NOT NULL,
    "QuestionBankId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_QuestionBankShares" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionCalibrations" (
    "Id" bigint NOT NULL,
    "QuestionId" bigint NOT NULL,
    "Version" integer NOT NULL,
    "IsActive" boolean NOT NULL,
    "A" double precision,
    "B" double precision,
    "C" double precision,
    "SEA" double precision,
    "SEB" double precision,
    "SEC" double precision,
    "Infit" double precision,
    "Outfit" double precision,
    "SampleSize" integer NOT NULL,
    "CalibrationRound" integer,
    "IsAnchor" boolean NOT NULL,
    "FixA" boolean NOT NULL,
    "FixB" boolean NOT NULL,
    "FixC" boolean NOT NULL,
    "Note" citext,
    "CreateStaffId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    CONSTRAINT "PK_QuestionCalibrations" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionCellAssignments" (
    "Id" bigint NOT NULL,
    "DetailId" bigint NOT NULL,
    "LevelId" bigint NOT NULL,
    "RequestCount" integer NOT NULL,
    "RequestId" bigint NOT NULL,
    CONSTRAINT "PK_QuestionCellAssignments" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionClo" (
    "QuestionId" bigint NOT NULL,
    "AnswerId" bigint NOT NULL,
    "CloCode" citext,
    "Id" bigint NOT NULL,
    "SetId" bigint NOT NULL,
    CONSTRAINT "PK_QuestionClo" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionContents" (
    "QuestionId" bigint NOT NULL,
    "WordContent" bytea,
    "TextContent" text,
    CONSTRAINT "PK_QuestionContents" PRIMARY KEY ("QuestionId")
);

CREATE TABLE "QuestionLevels" (
    "Code" citext NOT NULL,
    "Name" citext NOT NULL,
    "Note" citext,
    "Id" bigint NOT NULL,
    "ParentId" bigint DEFAULT 0 NOT NULL,
    "DisplayIndex" integer DEFAULT 0 NOT NULL,
    CONSTRAINT "PK_QuestionLevels" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionReviewerDecisionLogs" (
    "Id" bigint NOT NULL,
    "QuestionAssignmentId" bigint NOT NULL,
    "ReviewerId" bigint NOT NULL,
    "StaffId" bigint NOT NULL,
    "Decision" smallint NOT NULL,
    "PreviousDecision" smallint DEFAULT 0 NOT NULL,
    "Comment" varchar(1000),
    "DecisionDate" timestamp NOT NULL,
    "Round" integer DEFAULT 0 NOT NULL,
    CONSTRAINT "PK_QRDecisionLogs" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionReviewerDecisions" (
    "Id" bigint NOT NULL,
    "QuestionAssignmentId" bigint NOT NULL,
    "ReviewerId" bigint NOT NULL,
    "Decision" smallint NOT NULL,
    "Comment" varchar(1000),
    "DecisionDate" timestamp NOT NULL,
    CONSTRAINT "PK_QuestionReviewerDecisions" PRIMARY KEY ("Id")
);

CREATE TABLE "Questions" (
    "Code" citext NOT NULL,
    "HtmlContent" citext,
    "ParentId" bigint NOT NULL,
    "QuestionBankId" bigint NOT NULL,
    "SubjectDetailId" bigint NOT NULL,
    "ChildCount" integer NOT NULL,
    "LevelId" bigint NOT NULL,
    "Mixable" boolean NOT NULL,
    "QuestionType" smallint NOT NULL,
    "Status" smallint NOT NULL,
    "DisplayIndex" integer NOT NULL,
    "A" double precision NOT NULL,
    "B" double precision NOT NULL,
    "C" double precision NOT NULL,
    "Score" double precision NOT NULL,
    "DisplayType" smallint NOT NULL,
    "ChildCols" integer NOT NULL,
    "QuestionGroup" varchar(50),
    "HasWordContent" boolean NOT NULL,
    "ScoreRule" varchar(250),
    "Note" citext,
    "CreateStaffId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "UpdateStaffId" bigint NOT NULL,
    "UpdateDate" timestamp NOT NULL,
    "UseCount" integer NOT NULL,
    "SubjectId" bigint NOT NULL,
    "BulletType" smallint NOT NULL,
    "Deleted" boolean NOT NULL,
    "AttachType" varchar(40),
    "Variables" text,
    "Id" bigint NOT NULL,
    "OtherParams" varchar(500),
    "LockedToDate" timestamp,
    CONSTRAINT "PK_Questions" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionUsages" (
    "Id" bigint NOT NULL,
    "QuestionId" bigint NOT NULL,
    "YearId" bigint NOT NULL,
    "UsedCount" integer NOT NULL,
    CONSTRAINT "PK_QuestionUsages" PRIMARY KEY ("Id")
);

CREATE TABLE "QuestionUseRecords" (
    "Id" bigint NOT NULL,
    "QuestionId" bigint NOT NULL,
    "QuestionBankId" bigint NOT NULL,
    "TestId" bigint DEFAULT 0 NOT NULL,
    "TestGeneratorId" bigint DEFAULT 0 NOT NULL,
    "YearId" bigint DEFAULT 0 NOT NULL,
    "Source" smallint DEFAULT 0 NOT NULL,
    "CreateDate" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT "PK_QuestionUseRecords" PRIMARY KEY ("Id")
);

CREATE TABLE "Quizzes" (
    "Name" citext,
    "Questions" citext,
    "Status" smallint NOT NULL,
    "Duration" double precision NOT NULL,
    "SubjectId" bigint NOT NULL,
    "StaffId" bigint NOT NULL,
    "ShareType" smallint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Quizzes" PRIMARY KEY ("Id")
);

CREATE TABLE "RemarkRequests" (
    "CandidateId" bigint NOT NULL,
    "RequestDate" date NOT NULL,
    "Note" citext,
    "CreateDate" timestamp NOT NULL,
    "CreatorId" bigint NOT NULL,
    "Status" smallint NOT NULL,
    "MarkId" bigint,
    "EssayScoreAfter" double precision,
    "EssayScoreBefore" double precision,
    "ChoiseScoreAfter" double precision,
    "ChoiseScoreBefore" double precision,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_RemarkRequests" PRIMARY KEY ("Id")
);

CREATE TABLE "ReportTemplates" (
    "Id" bigint NOT NULL,
    "Code" citext NOT NULL,
    "Name" citext NOT NULL,
    "HeaderJson" text,
    "FooterJson" text,
    "ColumnsJson" text,
    "BodyJson" text,
    "Note" citext,
    "CreatedAt" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "CreatedBy" bigint,
    "UpdatedAt" timestamp,
    "UpdatedBy" bigint,
    CONSTRAINT "PK_ReportTemplates" PRIMARY KEY ("Id")
);

CREATE TABLE "Roles" (
    "RoleName" citext,
    "Note" citext,
    "Permissions" text,
    "AppId" bigint NOT NULL,
    "RoleId" bigint NOT NULL,
    CONSTRAINT "PK_Roles" PRIMARY KEY ("RoleId")
);

CREATE TABLE "RoomDevices" (
    "RoomId" bigint NOT NULL,
    "DeviceName" varchar(500),
    "IpAddress" varchar(500),
    "Status" smallint NOT NULL,
    "DisplayIndex" integer NOT NULL,
    "Id" bigint NOT NULL,
    "RowIndex" integer DEFAULT 0 NOT NULL,
    "ColumnIndex" integer DEFAULT 0 NOT NULL,
    CONSTRAINT "PK_RoomDevices" PRIMARY KEY ("Id")
);

CREATE TABLE "ScoreTypes" (
    "Code" citext NOT NULL,
    "Name" citext NOT NULL,
    "Note" citext,
    "Weight" double precision NOT NULL,
    "Type" smallint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_ScoreTypes_1" PRIMARY KEY ("Id")
);

CREATE TABLE "SharedFolders" (
    "FolderId" bigint NOT NULL,
    "StaffId" bigint NOT NULL,
    "Permisson" smallint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_SharedFolders" PRIMARY KEY ("Id")
);

CREATE TABLE "SharedLectures" (
    "StaffId" bigint NOT NULL,
    "ClassId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_SharedLectures" PRIMARY KEY ("Id")
);

CREATE TABLE "SharedTests" (
    "TestGeneratorId" bigint NOT NULL,
    "StaffId" bigint NOT NULL,
    "Permission" smallint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_SharedTests" PRIMARY KEY ("Id")
);

CREATE TABLE "SharedTestStructures" (
    "TestStructureId" bigint NOT NULL,
    "TargetId" bigint NOT NULL,
    "TargetType" smallint NOT NULL,
    "Permission" smallint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_SharedTestStructures" PRIMARY KEY ("Id")
);

CREATE TABLE "Simulations" (
    "Name" citext NOT NULL,
    "SubjectId" bigint NOT NULL,
    "ContentPath" varchar(500),
    "StaffId" bigint NOT NULL,
    "Status" smallint NOT NULL,
    "Shared" boolean NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Simulations" PRIMARY KEY ("Id")
);

CREATE TABLE "Skills" (
    "SkillCode" varchar(50) NOT NULL,
    "SkillName" varchar(500),
    CONSTRAINT "PK_Skills" PRIMARY KEY ("SkillCode")
);

CREATE TABLE "StaffDepts" (
    "DepartmentId" bigint NOT NULL,
    "StaffId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    "PositionId" bigint,
    CONSTRAINT "PK_StaffDepts" PRIMARY KEY ("Id")
);

CREATE TABLE "StaffExternalAccounts" (
    "StaffId" bigint NOT NULL,
    "AccountId" citext,
    "Password" citext,
    "Email" citext,
    "DisplayName" varchar(150),
    "AccountEnabled" boolean NOT NULL,
    "AccountType" smallint NOT NULL,
    "Created" boolean NOT NULL,
    CONSTRAINT "PK_StaffExternalAccounts_1" PRIMARY KEY ("StaffId")
);

CREATE TABLE "Staffs" (
    "Code" citext NOT NULL,
    "FullName" citext,
    "DateOfBirth" citext,
    "Gender" smallint NOT NULL,
    "Phone" citext,
    "Email" citext,
    "Address" citext,
    "NationalId" citext,
    "UserId" bigint NOT NULL,
    "Deleted" boolean NOT NULL,
    "DepartmentId" bigint NOT NULL,
    "Note" citext,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Staffs" PRIMARY KEY ("Id")
);

CREATE TABLE "StudentActivity" (
    "StudentId" bigint NOT NULL,
    "ActivityId" bigint NOT NULL,
    "JoinDate" timestamp NOT NULL,
    "Score" double precision NOT NULL,
    "Progress" double precision NOT NULL,
    "FinishedDate" timestamp NOT NULL,
    "TotalTime" double precision NOT NULL,
    "ContentId" bigint NOT NULL,
    "Token" citext,
    "GroupId" bigint,
    "Status" smallint NOT NULL,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_StudentActivity" PRIMARY KEY ("Id")
);

CREATE TABLE "StudentActivityComments" (
    "ParentId" bigint NOT NULL,
    "ActivityId" bigint NOT NULL,
    "StudentId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "UserId" bigint NOT NULL,
    "Content" citext NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_StudentActivityComments" PRIMARY KEY ("Id")
);

CREATE TABLE "StudentActivityData" (
    "StudentActivityId" bigint NOT NULL,
    "StudentId" bigint NOT NULL,
    "ActivityId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "PostedData" text NOT NULL,
    "MarkDetails" text,
    "EssayScore" double precision,
    CONSTRAINT "PK_StudentActivityData_1" PRIMARY KEY ("StudentActivityId")
);

CREATE TABLE "StudentActivityDataHistory" (
    "StudentActivityId" bigint NOT NULL,
    "StudentId" bigint NOT NULL,
    "ActivityId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "PostedData" text NOT NULL,
    "MarkDetails" text,
    "EssayScore" double precision,
    "EntryIndex" integer NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "Duration" integer NOT NULL,
    "ChoiceScore" double precision NOT NULL,
    "Passed" boolean NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_StudentActivityData_History" PRIMARY KEY ("Id")
);

CREATE TABLE "StudentAttendances" (
    "AttendanceId" bigint NOT NULL,
    "StudentId" bigint NOT NULL,
    "Status" smallint NOT NULL,
    "YearPart" integer NOT NULL,
    "Note" citext,
    "Longtitude" double precision,
    "Latitude" double precision,
    "VerifyData" varchar(2000),
    "VerifyDate" timestamp NOT NULL,
    "VerifyType" smallint NOT NULL,
    "Warning" boolean NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_StudentAttendances" PRIMARY KEY ("Id")
);

CREATE TABLE "StudentClo" (
    "StudentId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "CloCode" citext NOT NULL,
    "Score" double precision NOT NULL,
    "IsPassed" smallint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "SubjectId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    "Term" smallint,
    CONSTRAINT "PK_StudentClo" PRIMARY KEY ("Id")
);

CREATE TABLE "StudentCloScoreTypes" (
    "Id" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "StudentId" bigint NOT NULL,
    "CloCode" citext NOT NULL,
    "Score" double precision NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "SubjectId" bigint NOT NULL,
    "SetId" bigint NOT NULL,
    "ScoreTypeId" bigint,
    "Term" smallint,
    CONSTRAINT "PK_StudentCloScoreTypes" PRIMARY KEY ("Id")
);

CREATE TABLE "StudentExternalAccounts" (
    "StudentId" bigint NOT NULL,
    "AccountType" bigint NOT NULL,
    "AccountId" citext,
    "Email" citext NOT NULL,
    "DisplayName" varchar(255) NOT NULL,
    "Department" citext,
    "AccountEnabled" boolean NOT NULL,
    "TempPassword" varchar(255),
    "CreatedDate" timestamp NOT NULL,
    "Created" boolean NOT NULL,
    CONSTRAINT "PK__StudentE__32C52B99B1EAF9E3" PRIMARY KEY ("StudentId", "AccountType")
);

CREATE TABLE "StudentLessons" (
    "StudentId" bigint NOT NULL,
    "LessonId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "Status" smallint NOT NULL,
    "Score" double precision NOT NULL,
    "StartDate" timestamp NOT NULL,
    "FinishDate" timestamp,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_StudentLessons" PRIMARY KEY ("Id")
);

CREATE TABLE "StudentMajors" (
    "StudentId" bigint NOT NULL,
    "ProgramId" bigint NOT NULL,
    "MajorId" bigint NOT NULL,
    "ClassId" bigint NOT NULL,
    "CourseId" bigint NOT NULL,
    "StartDate" date NOT NULL,
    "Status" smallint NOT NULL,
    "MaxTime" integer NOT NULL,
    "Score" double precision NOT NULL,
    "GroupName" varchar(50),
    "Note" citext,
    "LevelId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_StudentMajors" PRIMARY KEY ("Id")
);

CREATE TABLE "StudentPlo" (
    "PloCode" citext NOT NULL,
    "StudentId" bigint NOT NULL,
    "Score" double precision NOT NULL,
    "IsPassed" boolean NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "ProgramId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_StudentPlo" PRIMARY KEY ("Id")
);

CREATE TABLE "StudentQuizAnswerLogs" (
    "Id" bigint NOT NULL,
    "StudentId" bigint NOT NULL,
    "QuizId" bigint NOT NULL,
    "ActivityId" bigint NOT NULL,
    "QuestionId" bigint NOT NULL,
    "ClassId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "Answers" citext,
    "IsCorrect" boolean NOT NULL,
    "ElapsedMs" integer NOT NULL,
    "CreateDate" timestamp NOT NULL,
    CONSTRAINT "PK_StudentQuizAnswerLogs" PRIMARY KEY ("Id")
);

CREATE TABLE "StudentQuizAnswers" (
    "StudentId" bigint NOT NULL,
    "QuizId" bigint NOT NULL,
    "QuestionId" bigint NOT NULL,
    "ActivityId" bigint NOT NULL,
    "Answers" citext,
    "Score" double precision NOT NULL,
    "Time" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_StudentQuizAnswers" PRIMARY KEY ("Id")
);

CREATE TABLE "Students" (
    "Avatar" citext,
    "Code" citext NOT NULL,
    "FullName" citext,
    "DateOfBirth" citext,
    "Gender" smallint NOT NULL,
    "Phone" citext,
    "Email" citext,
    "Address" citext,
    "NationalId" citext,
    "UserId" bigint NOT NULL,
    "DepartmentId" bigint NOT NULL,
    "Status" smallint NOT NULL,
    "LastUpdate" timestamp,
    "CreateDate" timestamp NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Students" PRIMARY KEY ("Id")
);

CREATE TABLE "SubjectDetailPerms" (
    "DetailId" bigint NOT NULL,
    "QuestionBankShareId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_SubjectDetailPerms" PRIMARY KEY ("Id")
);

CREATE TABLE "SubjectDetails" (
    "ParentId" bigint NOT NULL,
    "Name" citext,
    "Note" citext,
    "CodeType" smallint NOT NULL,
    "QuestionBankId" bigint NOT NULL,
    "DisplayIndex" integer NOT NULL,
    "Id" bigint NOT NULL,
    "Code" citext,
    CONSTRAINT "PK_SubjectDetails" PRIMARY KEY ("Id")
);

CREATE TABLE "SubjectManagers" (
    "SubjectId" bigint NOT NULL,
    "StaffId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_SubjectManagers" PRIMARY KEY ("Id")
);

CREATE TABLE "Subjects" (
    "Code" citext,
    "Name" citext,
    "Note" citext,
    "Weight" double precision NOT NULL,
    "DepartmentId" bigint NOT NULL,
    "ScoreTypes" varchar(500),
    "Formular" varchar(500),
    "Logo" varchar(500),
    "Id" bigint NOT NULL,
    "ServerId" citext,
    "NameEn" varchar(150),
    CONSTRAINT "PK_Table_1" PRIMARY KEY ("Id")
);

CREATE TABLE "SubjectScoreTypes" (
    "SubjectId" bigint NOT NULL,
    "ScoreTypeId" bigint NOT NULL,
    "Weight" double precision NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_SubjectScoreTypes" PRIMARY KEY ("Id")
);

CREATE TABLE "SubjectTests" (
    "SubjectId" bigint NOT NULL,
    "TestGeneratorId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_TestSubjects" PRIMARY KEY ("Id")
);

CREATE TABLE "SupervisorPasswordHistory" (
    "Id" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "ExamSubjectId" bigint NOT NULL,
    "CreatorId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "PasswordData" text,
    "PrintContent" text,
    CONSTRAINT "PK_SupervisorPasswordHistory" PRIMARY KEY ("Id")
);

CREATE TABLE "Survey" (
    "Name" citext NOT NULL,
    "UserId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "Items" citext NOT NULL,
    "Instruction" citext,
    "Thanks" citext,
    "Status" smallint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK__Survey__3214EC07B4B3D30C" PRIMARY KEY ("Id")
);

CREATE TABLE "SurveyAnswers" (
    "SurveyId" bigint NOT NULL,
    "ResponseId" bigint NOT NULL,
    "QuestionId" bigint NOT NULL,
    "AnswerId" bigint NOT NULL,
    "Content" citext,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK__SurveyAn__3214EC07669D8BDE" PRIMARY KEY ("Id")
);

CREATE TABLE "SurveyResponses" (
    "SessionId" varchar(45) NOT NULL,
    "UserId" bigint NOT NULL,
    "UserInfo" text,
    "ResponseDate" timestamp NOT NULL,
    "SurveyId" bigint NOT NULL,
    "Status" smallint NOT NULL,
    "TargetId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK__SurveyRe__3214EC073C763600" PRIMARY KEY ("Id")
);

CREATE TABLE "SyncData" (
    "Module" citext NOT NULL,
    "SourceId" citext,
    "TargetId" citext,
    "DateCreate" timestamp NOT NULL,
    "SyncUserId" bigint NOT NULL,
    "Partner" citext,
    "Data" citext,
    "SyncId" bigint NOT NULL,
    CONSTRAINT "PK_SyncData" PRIMARY KEY ("SyncId")
);

CREATE TABLE "TestAnalysis" (
    "Name" citext,
    "StaffId" bigint NOT NULL,
    "Result" text,
    "Type" smallint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "TargetId" citext,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_TestAnalysis" PRIMARY KEY ("Id")
);

CREATE TABLE "TestAttachments" (
    "TestId" bigint NOT NULL,
    "Path" varchar(500) NOT NULL,
    "TestContent" text,
    "MediaPath" text,
    "AnswerPath" varchar(500),
    "StartQuestionIndex" integer NOT NULL,
    CONSTRAINT "PK_TestAttachments" PRIMARY KEY ("TestId")
);

CREATE TABLE "TestCollections" (
    "Name" citext,
    "Note" citext,
    "Status" smallint NOT NULL,
    "SubjectId" bigint NOT NULL,
    "StaffId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "DepartmentId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_TestCollections" PRIMARY KEY ("Id")
);

CREATE TABLE "TestComments" (
    "StaffId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "Comment" varchar(500) NOT NULL,
    "TestGeneratorId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_TestComments" PRIMARY KEY ("Id")
);

CREATE TABLE "TestFlows" (
    "Id" bigint NOT NULL,
    "TestGeneratorId" bigint NOT NULL,
    "DateSent" timestamp,
    "FromStaffId" bigint NOT NULL,
    "ToStaffId" bigint NOT NULL,
    "Note" citext,
    "Status" smallint NOT NULL,
    "NodeId" varchar(50) NOT NULL,
    CONSTRAINT "PK_TestFlows" PRIMARY KEY ("Id")
);

CREATE TABLE "TestGeneratorFiles" (
    "Id" bigint NOT NULL,
    "TestGeneratorId" bigint NOT NULL,
    "FileName" varchar(400) NOT NULL,
    "StoredPath" varchar(1000) NOT NULL,
    "ContentType" citext,
    "SizeBytes" bigint,
    "CreateDate" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT "PK_TestGeneratorFiles" PRIMARY KEY ("Id")
);

CREATE TABLE "TestGenerators" (
    "Name" citext NOT NULL,
    "StaffId" bigint NOT NULL,
    "DepartmentId" bigint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "TestStructureId" bigint NOT NULL,
    "ShareType" smallint NOT NULL,
    "TestCount" integer NOT NULL,
    "Note" citext,
    "Status" smallint NOT NULL,
    "MixAll" boolean NOT NULL,
    "Duration" double precision NOT NULL,
    "TimeType" smallint NOT NULL,
    "TemplateId" bigint NOT NULL,
    "TestParts" citext,
    "SubjectId" bigint NOT NULL,
    "QuestionBankId" bigint NOT NULL,
    "OtherInfo" citext,
    "IsPartScore" boolean NOT NULL,
    "CodeSuffix" citext,
    "CodePrefix" varchar(20),
    "CodeLength" integer NOT NULL,
    "Id" bigint NOT NULL,
    "OtherParams" varchar(500),
    "YearId" bigint,
    CONSTRAINT "PK_TestGenerators" PRIMARY KEY ("Id")
);

CREATE TABLE "TestInCollections" (
    "TestCollectionId" bigint NOT NULL,
    "TestId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_TestInCollections" PRIMARY KEY ("Id")
);

CREATE TABLE "TestParts" (
    "Name" citext,
    "QuestionType" smallint NOT NULL,
    "TestStructId" bigint NOT NULL,
    "Duration" double precision NOT NULL,
    "Weight" double precision NOT NULL,
    "Fixed" boolean NOT NULL,
    "DisplayIndex" integer NOT NULL,
    "QuestionCount" integer NOT NULL,
    "Details" text NOT NULL,
    "LayoutCols" integer NOT NULL,
    "ScoreRule" text,
    "Id" bigint NOT NULL,
    "StartIndex" integer NOT NULL,
    "Footer" varchar(150),
    "SelectQuestionMode" smallint DEFAULT 0 NOT NULL,
    "ParentId" bigint DEFAULT 0 NOT NULL,
    "IsSection" boolean DEFAULT false NOT NULL,
    CONSTRAINT "PK_TestParts" PRIMARY KEY ("Id")
);

CREATE TABLE "TestQuestions" (
    "QuestionId" bigint NOT NULL,
    "TestId" bigint NOT NULL,
    "PartId" bigint NOT NULL,
    "DisplayIndex" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_TestQuestions" PRIMARY KEY ("Id")
);

CREATE TABLE "Tests" (
    "Code" citext NOT NULL,
    "TestStructureId" bigint NOT NULL,
    "ParentId" bigint NOT NULL,
    "TestGeneratorId" bigint NOT NULL,
    "Questions" citext,
    "CreateDate" timestamp NOT NULL,
    "FixedContent" boolean,
    "EssayCount" integer NOT NULL,
    "ChoiseCount" integer NOT NULL,
    "EssayScore" double precision NOT NULL,
    "ChoiseScore" double precision NOT NULL,
    "Deleted" boolean NOT NULL,
    "Id" bigint NOT NULL,
    "FilePath" varchar(500),
    CONSTRAINT "PK_Tests" PRIMARY KEY ("Id")
);

CREATE TABLE "TestStructureFiles" (
    "Id" bigint NOT NULL,
    "TestStructureId" bigint NOT NULL,
    "FileName" varchar(400) NOT NULL,
    "StoredPath" varchar(1000) NOT NULL,
    "ContentType" citext,
    "SizeBytes" bigint,
    "CreateDate" timestamp NOT NULL,
    CONSTRAINT "PK_TestStructureFiles" PRIMARY KEY ("Id")
);

CREATE TABLE "TestStructures" (
    "Name" citext NOT NULL,
    "Note" citext,
    "MixAll" boolean NOT NULL,
    "Duration" double precision NOT NULL,
    "TimeType" smallint NOT NULL,
    "TemplateId" bigint NOT NULL,
    "QuestionBankId" bigint NOT NULL,
    "QuestionCount" integer NOT NULL,
    "UseDocuments" boolean NOT NULL,
    "Status" smallint NOT NULL,
    "StaffId" bigint NOT NULL,
    "IsPartScore" boolean NOT NULL,
    "SelectQuestionMode" smallint NOT NULL,
    "Id" bigint NOT NULL,
    "Options" text,
    "ShareType" smallint NOT NULL DEFAULT 0,
    CONSTRAINT "PK_TestStructures" PRIMARY KEY ("Id")
);

CREATE TABLE "TestTemplates" (
    "Name" citext NOT NULL,
    "GroupQuestionTitle" varchar(50),
    "QuestionTitle" varchar(50),
    "ScoreTitle" varchar(50),
    "TemplateContent" varchar(1000),
    "TemplateAnswer" varchar(1000),
    "QuestionNoScoreTitle" varchar(50),
    "FooterUseDocument" varchar(1000),
    "FooterNoDocument" varchar(1000),
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_TestTemplates" PRIMARY KEY ("Id")
);

CREATE TABLE "TestUsages" (
    "ExamSubjectId" bigint NOT NULL,
    "TestGeneratorId" bigint NOT NULL,
    "UseTests" text,
    "YearPart" integer NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_TestUsages" PRIMARY KEY ("Id")
);

CREATE TABLE "TrainingPrograms" (
    "Code" citext,
    "Name" citext,
    "MajorId" bigint NOT NULL,
    "Status" smallint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "Note" citext,
    "YearId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_TrainingPrograms" PRIMARY KEY ("Id")
);

CREATE TABLE "TrainingTypes" (
    "Name" citext NOT NULL,
    "Note" citext,
    "Status" smallint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_TrainingTypes" PRIMARY KEY ("Id")
);

CREATE TABLE "Translates" (
    "Id" bigint NOT NULL,
    "TableName" varchar(50) NOT NULL,
    "Language" citext NOT NULL,
    "TextContent" varchar(50),
    CONSTRAINT "PK_Translates" PRIMARY KEY ("Id", "TableName", "Language")
);

CREATE TABLE "UserRoles" (
    "RoleId" bigint NOT NULL,
    "UserId" bigint NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_UserRoles" PRIMARY KEY ("Id")
);

CREATE TABLE "Users" (
    "UserName" citext NOT NULL,
    "Password" citext,
    "RoleType" smallint NOT NULL,
    "Status" smallint NOT NULL,
    "CreateDate" timestamp NOT NULL,
    "Avatar" citext,
    "DeviceId" varchar(50),
    "OwnerId" bigint NOT NULL,
    "LastDate" timestamp,
    "UserId" bigint NOT NULL,
    CONSTRAINT "PK_Users" PRIMARY KEY ("UserId")
);

CREATE TABLE "VideoViewLogs" (
    "Id" bigint NOT NULL,
    "StudentId" bigint NOT NULL,
    "ActivityId" bigint NOT NULL,
    "ClassId" bigint NOT NULL,
    "YearPart" integer NOT NULL,
    "CreateDate" timestamp NOT NULL,
    CONSTRAINT "PK_VideoViewLogs" PRIMARY KEY ("Id")
);

CREATE TABLE "Years" (
    "Code" citext NOT NULL,
    "Name" citext NOT NULL,
    "StartDate" date NOT NULL,
    "Id" bigint NOT NULL,
    CONSTRAINT "PK_Years" PRIMARY KEY ("Id")
);

ALTER TABLE "AttendanceGroupMembers" ALTER COLUMN "FaceSynced" SET DEFAULT false;
ALTER TABLE "AttendanceGroups" ALTER COLUMN "IsActive" SET DEFAULT true;
ALTER TABLE "AttendanceGroups" ALTER COLUMN "CreatedAt" SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE "AttendanceSessions" ALTER COLUMN "CreatedAt" SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE "AttendanceSessions" ALTER COLUMN "IsActive" SET DEFAULT true;
ALTER TABLE "BonusPointHistories" ALTER COLUMN "TargetField" SET DEFAULT 'bonus';
ALTER TABLE "BonusPointHistories" ALTER COLUMN "CreatedAt" SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE "BonusPointHistories" ALTER COLUMN "IsDeleted" SET DEFAULT false;
ALTER TABLE "ClassPostAttachments" ALTER COLUMN "IsImage" SET DEFAULT false;
ALTER TABLE "ClassPosts" ALTER COLUMN "IsPinned" SET DEFAULT false;
ALTER TABLE "LearningJournalCommentAttachments" ALTER COLUMN "AttachmentType" SET DEFAULT 1;
ALTER TABLE "LearningJournalComments" ALTER COLUMN "Depth" SET DEFAULT 0;
ALTER TABLE "LearningJournalComments" ALTER COLUMN "ContentFormat" SET DEFAULT 1;
ALTER TABLE "LearningJournalComments" ALTER COLUMN "IsPinned" SET DEFAULT false;
ALTER TABLE "LearningJournalComments" ALTER COLUMN "IsDeleted" SET DEFAULT false;
ALTER TABLE "LearningJournalEntries" ALTER COLUMN "Visibility" SET DEFAULT 1;
ALTER TABLE "LearningJournalEvidences" ALTER COLUMN "EvidenceType" SET DEFAULT 1;
ALTER TABLE "NotificationDevices" ALTER COLUMN "LastAccess" SET DEFAULT NULL;
ALTER TABLE "QuestionAssignmentComments" ALTER COLUMN "IsDeleted" SET DEFAULT false;
ALTER TABLE "QuestionCalibrations" ALTER COLUMN "Version" SET DEFAULT 1;
ALTER TABLE "QuestionCalibrations" ALTER COLUMN "IsActive" SET DEFAULT true;
ALTER TABLE "QuestionCalibrations" ALTER COLUMN "SampleSize" SET DEFAULT 0;
ALTER TABLE "QuestionCalibrations" ALTER COLUMN "IsAnchor" SET DEFAULT false;
ALTER TABLE "QuestionCalibrations" ALTER COLUMN "FixA" SET DEFAULT false;
ALTER TABLE "QuestionCalibrations" ALTER COLUMN "FixB" SET DEFAULT false;
ALTER TABLE "QuestionCalibrations" ALTER COLUMN "FixC" SET DEFAULT false;
ALTER TABLE "QuestionCalibrations" ALTER COLUMN "CreateDate" SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE "StudentExternalAccounts" ALTER COLUMN "CreatedDate" SET DEFAULT CURRENT_TIMESTAMP;

CREATE INDEX "IX_Answers" ON "Answers" ("QuestionId");
CREATE INDEX "IX_AttendanceGroupMembers_FaceSynced" ON "AttendanceGroupMembers" ("GroupId", "FaceSynced");
CREATE INDEX "IX_AttendanceGroupMembers_GroupId" ON "AttendanceGroupMembers" ("GroupId");
CREATE UNIQUE INDEX "UX_AttendanceGroupMembers_Group_Student" ON "AttendanceGroupMembers" ("GroupId", "StudentId");
CREATE INDEX "IX_AttendanceGroups_GroupType" ON "AttendanceGroups" ("GroupType", "IsActive");
CREATE INDEX "IX_AttendanceGroups_Module_IsActive" ON "AttendanceGroups" ("Module", "IsActive");
CREATE UNIQUE INDEX "UX_AttendanceGroups_GroupId" ON "AttendanceGroups" ("GroupId");
CREATE INDEX "IX_AttendanceResults_GroupId_VerifiedAt" ON "AttendanceResults" ("GroupId", "VerifiedAt" DESC);
CREATE INDEX "IX_AttendanceResults_SessionId" ON "AttendanceResults" ("SessionId");
CREATE INDEX "IX_AttendanceResults_SessionId_Status" ON "AttendanceResults" ("SessionId", "Status");
CREATE UNIQUE INDEX "UX_AttendanceResults_Session_Student" ON "AttendanceResults" ("SessionId", "StudentId");
CREATE INDEX "IX_AttendanceSessions_ExpireAt" ON "AttendanceSessions" ("ExpireAt", "IsActive");
CREATE INDEX "IX_AttendanceSessions_GroupId_IsActive" ON "AttendanceSessions" ("GroupId", "IsActive");
CREATE UNIQUE INDEX "UX_AttendanceSessions_SessionId" ON "AttendanceSessions" ("SessionId");
CREATE INDEX "IX_BonusPointHistories_BatchCode" ON "BonusPointHistories" ("BatchCode");
CREATE INDEX "IX_BonusPointHistories_ClassStudent" ON "BonusPointHistories" ("ClassSubjectId", "StudentId", "YearPart", "IsDeleted");
CREATE INDEX "IX_BonusPointHistories_Source" ON "BonusPointHistories" ("SourceType", "SourceId");
CREATE INDEX "IX_CandidateCloScores_CandidateId" ON "CandidateCloScores" ("CandidateId");
CREATE INDEX "IX_CandidateCloScores_CloCode" ON "CandidateCloScores" ("CloCode");
CREATE INDEX "IX_Candidates_ExamSubject" ON "Candidates" ("ExamSubjectId");
CREATE INDEX "IX_Candidates_Student" ON "Candidates" ("StudentId");
CREATE INDEX "IX_Candidates_YearPart" ON "Candidates" ("YearPart");
CREATE INDEX "IX_ClassPostAttachments_Post" ON "ClassPostAttachments" ("PostId", "CreateDate" DESC);
CREATE INDEX "IX_ClassPostComments_Post_CreateDate" ON "ClassPostComments" ("PostId", "CreateDate" DESC);
CREATE INDEX "IX_ClassPostLinks_Post" ON "ClassPostLinks" ("PostId", "CreateDate" DESC);
CREATE INDEX "IX_ClassReactions_Target" ON "ClassReactions" ("TargetType", "TargetId", "ReactionType");
CREATE UNIQUE INDEX "UX_ClassReactions_Uniq" ON "ClassReactions" ("TargetType", "TargetId", "UserId");
CREATE INDEX "IX_ExamChatMessages_Personal" ON "ExamChatMessages" ("ReceiverId", "ExamSubjectId", "MessageType");
CREATE INDEX "IX_ExamChatMessages_Subject" ON "ExamChatMessages" ("ExamSubjectId", "SlotId", "RoomId", "MessageType");
CREATE INDEX "IX_ExamChatMessages_Supervisor" ON "ExamChatMessages" ("ExamSubjectId", "MessageType");
CREATE INDEX "IX_ExamChatMessages_Time" ON "ExamChatMessages" ("ExamSubjectId", "CreatedTime" DESC);
CREATE INDEX "IX_ExamChatMessages_YearPart" ON "ExamChatMessages" ("YearPart", "ExamSubjectId");
CREATE INDEX "IX_ESA_Staff_Year" ON "ExamSubjectAssignments" ("StaffId", "YearPart");
CREATE UNIQUE INDEX "UX_ESA_ExamSubject_Year" ON "ExamSubjectAssignments" ("ExamSubjectId", "YearPart");
CREATE INDEX "IX_ESATG_TG" ON "ExamSubjectAssignmentTestGenerators" ("TestGeneratorId");
CREATE UNIQUE INDEX "UX_ESATG_Assignment_TG" ON "ExamSubjectAssignmentTestGenerators" ("ExamSubjectAssignmentId", "TestGeneratorId");
CREATE INDEX "IX_ExamSubjectClos_CloCode" ON "ExamSubjectClos" ("CloCode");
CREATE INDEX "IX_ExamSubjectClos_ExamSubjectId" ON "ExamSubjectClos" ("ExamSubjectId");
CREATE INDEX "IX_LJCA_CommentId" ON "LearningJournalCommentAttachments" ("CommentId");
CREATE INDEX "IX_LJCM_CommentId" ON "LearningJournalCommentMentions" ("CommentId");
CREATE INDEX "IX_LJCM_User_Date" ON "LearningJournalCommentMentions" ("MentionedUserId", "CreateDate" DESC);
CREATE INDEX "IX_LJCR_Comment_Type" ON "LearningJournalCommentReactions" ("CommentId", "ReactionType");
CREATE UNIQUE INDEX "UX_LJCR_Comment_User" ON "LearningJournalCommentReactions" ("CommentId", "UserId");
CREATE INDEX "IX_LJC_Entry_Date" ON "LearningJournalComments" ("EntryId", "CreateDate" DESC);
CREATE INDEX "IX_LJC_Entry_Parent" ON "LearningJournalComments" ("EntryId", "ParentCommentId", "CreateDate");
CREATE INDEX "IX_LJC_Root_Date" ON "LearningJournalComments" ("RootCommentId", "CreateDate");
CREATE INDEX "IX_LJE_ClassSubject_Status_Date" ON "LearningJournalEntries" ("ClassSubjectId", "Status", "CreateDate" DESC);
CREATE INDEX "IX_LJE_Student_ClassSubject" ON "LearningJournalEntries" ("StudentId", "ClassSubjectId", "CreateDate" DESC);
CREATE INDEX "IX_LJE_TypeId" ON "LearningJournalEntries" ("TypeId");
CREATE INDEX "IX_LJEv_EntryId" ON "LearningJournalEvidences" ("EntryId");
CREATE INDEX "IX_LJR_EntryId_Date" ON "LearningJournalReviews" ("EntryId", "CreateDate" DESC);
CREATE INDEX "IX_LJT_Scope_ClassSubject" ON "LearningJournalTypes" ("Scope", "ClassSubjectId");
CREATE INDEX "IX_LJT_Scope_Subject" ON "LearningJournalTypes" ("Scope", "SubjectId");
CREATE INDEX "IX_LJTS_ClassSubject" ON "LearningJournalTypeSettings" ("ClassSubjectId", "IsEnabled", "SortOrder");
CREATE UNIQUE INDEX "UX_LJTS_ClassSubject_Type" ON "LearningJournalTypeSettings" ("ClassSubjectId", "TypeId");
CREATE INDEX "IX_Positions_RoleType" ON "Positions" ("RoleType");
CREATE UNIQUE INDEX "UX_Positions_Code" ON "Positions" ("Code");
CREATE INDEX "IX_PracticeAnswers_Question" ON "PracticeAnswers" ("QuestionId");
CREATE INDEX "IX_PracticeAnswers_Session" ON "PracticeAnswers" ("SessionId");
CREATE UNIQUE INDEX "IX_PracticeAnswers_SessionQuestion" ON "PracticeAnswers" ("SessionId", "QuestionIndex");
CREATE INDEX "IX_PracticeSessions_Activity" ON "PracticeSessions" ("ActivityId", "YearPart");
CREATE INDEX "IX_PracticeSessions_Status" ON "PracticeSessions" ("Status");
CREATE INDEX "IX_PracticeSessions_StudentActivity" ON "PracticeSessions" ("StudentId", "ActivityId", "YearPart");
CREATE INDEX "IX_QAComments_Assignment" ON "QuestionAssignmentComments" ("AssignmentId", "CreateDate");
CREATE INDEX "IX_QAComments_Question" ON "QuestionAssignmentComments" ("QuestionAssignmentId", "CreateDate");
CREATE INDEX "IX_QAReviewers_Staff" ON "QuestionAssignmentReviewers" ("StaffId", "Status");
CREATE UNIQUE INDEX "IX_QAReviewers_Unique" ON "QuestionAssignmentReviewers" ("AssignmentId", "StaffId");
CREATE INDEX "IX_QAReviews_Assignment" ON "QuestionAssignmentReviews" ("AssignmentId", "Round");
CREATE INDEX "IX_QuestionAssignments_TargetReplaceId" ON "QuestionAssignments" ("TargetReplaceId");
CREATE INDEX "IX_QuestionAttachments_QuestionId" ON "QuestionAttachments" ("QuestionId");
CREATE INDEX "IX_QuestionCalibrations_QuestionId_Active" ON "QuestionCalibrations" ("QuestionId", "IsActive");
CREATE INDEX "IX_QuestionLevels_ParentId" ON "QuestionLevels" ("ParentId");
CREATE INDEX "IX_QRDecisionLogs_QA" ON "QuestionReviewerDecisionLogs" ("QuestionAssignmentId");
CREATE INDEX "IX_QRDecisionLogs_Reviewer" ON "QuestionReviewerDecisionLogs" ("ReviewerId", "DecisionDate");
CREATE INDEX "IX_QRDecisionLogs_Staff" ON "QuestionReviewerDecisionLogs" ("StaffId", "DecisionDate");
CREATE INDEX "IX_QRDecisions_Reviewer" ON "QuestionReviewerDecisions" ("ReviewerId", "Decision");
CREATE UNIQUE INDEX "IX_QRDecisions_Unique" ON "QuestionReviewerDecisions" ("QuestionAssignmentId", "ReviewerId");
CREATE INDEX "IX_Questions" ON "Questions" ("ParentId");
CREATE INDEX "IX_QuestionUseRecords_QuestionBankId" ON "QuestionUseRecords" ("QuestionBankId");
CREATE INDEX "IX_QuestionUseRecords_QuestionId" ON "QuestionUseRecords" ("QuestionId");
CREATE INDEX "IX_QuestionUseRecords_TestGeneratorId" ON "QuestionUseRecords" ("TestGeneratorId");
CREATE INDEX "IX_QuestionUseRecords_TestId" ON "QuestionUseRecords" ("TestId");
CREATE INDEX "IX_StaffDepts_Position" ON "StaffDepts" ("PositionId");
CREATE INDEX "FK_Survey_Users_Idx" ON "Survey" ("UserId");
CREATE INDEX "FK_SurveyAnswers_Idx" ON "SurveyAnswers" ("ResponseId");
CREATE INDEX "FK_SurveyAnswerSurvey_Idx" ON "SurveyAnswers" ("SurveyId");
CREATE INDEX "FK_SurveyQuestions_Idx" ON "SurveyAnswers" ("QuestionId");
CREATE INDEX "FK_SurveyResponse_Idx" ON "SurveyResponses" ("SurveyId");
CREATE INDEX "IX_StudentQuizAnswerLogs_Activity" ON "StudentQuizAnswerLogs" ("ActivityId", "YearPart");
CREATE INDEX "IX_StudentQuizAnswerLogs_StudentQuestion" ON "StudentQuizAnswerLogs" ("StudentId", "ActivityId", "QuestionId", "Id");
CREATE INDEX "IX_VideoViewLogs_Activity" ON "VideoViewLogs" ("ActivityId", "YearPart");
CREATE INDEX "IX_VideoViewLogs_StudentActivity" ON "VideoViewLogs" ("StudentId", "ActivityId", "YearPart");
CREATE INDEX "IX_FileDownloadLogs_Activity" ON "FileDownloadLogs" ("ActivityId", "YearPart");
CREATE INDEX "IX_FileDownloadLogs_StudentActivity" ON "FileDownloadLogs" ("StudentId", "ActivityId", "YearPart");
CREATE INDEX "IX_SyncData_Source" ON "SyncData" ("Module", "SourceId");
CREATE INDEX "IX_SyncData_Target" ON "SyncData" ("Module", "TargetId");
CREATE INDEX "IX_TestGeneratorFiles_TestGeneratorId" ON "TestGeneratorFiles" ("TestGeneratorId");
CREATE INDEX "IX_TestParts_TestStructId_ParentId" ON "TestParts" ("TestStructId", "ParentId");
CREATE INDEX "IX_TestQuestions" ON "TestQuestions" ("TestId", "QuestionId");
CREATE INDEX "IX_Tests" ON "Tests" ("ParentId");
CREATE INDEX "IX_TestStructureFiles_TestStructureId" ON "TestStructureFiles" ("TestStructureId");

ALTER TABLE "AccessDeviceFaces" ADD CONSTRAINT "FK_AccessDeviceFaces_AccessDevices" FOREIGN KEY ("DeviceId") REFERENCES "AccessDevices" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ActivityData" ADD CONSTRAINT "FK_ActivityData_ClassActivities" FOREIGN KEY ("ActivityId") REFERENCES "ClassActivities" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "AnswerContents" ADD CONSTRAINT "FK_AnswerContents_Answers" FOREIGN KEY ("AnswerId") REFERENCES "Answers" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Answers" ADD CONSTRAINT "FK_Answers_Questions" FOREIGN KEY ("QuestionId") REFERENCES "Questions" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "AttendanceGroupMembers" ADD CONSTRAINT "FK_AttendanceGroupMembers_AttendanceGroups" FOREIGN KEY ("GroupId") REFERENCES "AttendanceGroups" ("Id");
ALTER TABLE "AttendanceGroupMembers" ADD CONSTRAINT "FK_AttendanceGroupMembers_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id");
ALTER TABLE "AttendanceResults" ADD CONSTRAINT "FK_AttendanceResults_AttendanceSessions" FOREIGN KEY ("SessionId") REFERENCES "AttendanceSessions" ("SessionId");
ALTER TABLE "AttendanceResults" ADD CONSTRAINT "FK_AttendanceResults_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id");
ALTER TABLE "Attendances" ADD CONSTRAINT "FK_Attendances_ClassSubjects" FOREIGN KEY ("ClassId") REFERENCES "ClassSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "AttendanceSessions" ADD CONSTRAINT "FK_AttendanceSessions_AttendanceGroups" FOREIGN KEY ("GroupId") REFERENCES "AttendanceGroups" ("Id");
ALTER TABLE "BonusPointHistories" ADD CONSTRAINT "FK_BonusPointHistories_ClassSubjects" FOREIGN KEY ("ClassSubjectId") REFERENCES "ClassSubjects" ("Id");
ALTER TABLE "BonusPointHistories" ADD CONSTRAINT "FK_BonusPointHistories_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id");
ALTER TABLE "CalendarEventAttendees" ADD CONSTRAINT "FK_CalendarEventAttendees_CalendarEvents" FOREIGN KEY ("CalendarEventId") REFERENCES "CalendarEvents" ("Id");
ALTER TABLE "CalendarEvents" ADD CONSTRAINT "FK_CalendarEvents_Attendances" FOREIGN KEY ("AttendanceId") REFERENCES "Attendances" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "CalendarEvents" ADD CONSTRAINT "FK_CalendarEvents_ClassSubjects" FOREIGN KEY ("ClassId") REFERENCES "ClassSubjects" ("Id");
ALTER TABLE "CandidateAnswers" ADD CONSTRAINT "FK_CandidateAnswers_Candidates" FOREIGN KEY ("CandidateId") REFERENCES "Candidates" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "CandidateAnswers" ADD CONSTRAINT "FK_CandidateAnswers_Questions" FOREIGN KEY ("QuestionId") REFERENCES "Questions" ("Id");
ALTER TABLE "CandidateCloScores" ADD CONSTRAINT "FK_CandidateCloScores_Candidates" FOREIGN KEY ("CandidateId") REFERENCES "Candidates" ("Id") ON DELETE CASCADE;
ALTER TABLE "CandidateCommands" ADD CONSTRAINT "FK_CandidateCommands_Candidates" FOREIGN KEY ("CandidateId") REFERENCES "Candidates" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "CandidateEvents" ADD CONSTRAINT "FK_CandidateEvents_Candidates" FOREIGN KEY ("CandidateId") REFERENCES "Candidates" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "CandidateGroups" ADD CONSTRAINT "FK_CandidateGroups_ExamSubjects" FOREIGN KEY ("ExamSubjectId") REFERENCES "ExamSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "CandidateHistory" ADD CONSTRAINT "FK_CandidateHistory_Candidates" FOREIGN KEY ("CandidateId") REFERENCES "Candidates" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "CandidateOtherInfo" ADD CONSTRAINT "FK_CandidateOtherInfo_CandidateOtherInfo" FOREIGN KEY ("CandidateId") REFERENCES "Candidates" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "CandidatePaperDetails" ADD CONSTRAINT "FK_CandidatePaperDetails_Candidates" FOREIGN KEY ("CandidateId") REFERENCES "Candidates" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "CandidatePapers" ADD CONSTRAINT "FK_CandidatePapers_Candidates" FOREIGN KEY ("CandidateId") REFERENCES "Candidates" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "CandidatePartScores" ADD CONSTRAINT "FK_CandidatePartScores_Candidates" FOREIGN KEY ("CandidateId") REFERENCES "Candidates" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Candidates" ADD CONSTRAINT "FK_Candidates_ExamSubjects" FOREIGN KEY ("ExamSubjectId") REFERENCES "ExamSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Candidates" ADD CONSTRAINT "FK_Candidates_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "CandidateVerification" ADD CONSTRAINT "FK_CandidateVerification_Candidates" FOREIGN KEY ("CandidateId") REFERENCES "Candidates" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ChatBoxMembers" ADD CONSTRAINT "FK_ChatBoxMembers_ChatBoxes" FOREIGN KEY ("BoxId") REFERENCES "ChatBoxes" ("BoxId") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ChatMessages" ADD CONSTRAINT "FK_ChatMessages_ChatMessages" FOREIGN KEY ("BoxId") REFERENCES "ChatBoxes" ("BoxId") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ChatUserMessages" ADD CONSTRAINT "FK_ChatUserMessages_ChatMessages" FOREIGN KEY ("MessageId") REFERENCES "ChatMessages" ("ChatId") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ClassActivities" ADD CONSTRAINT "FK_ClassActivities_ClassSubjects" FOREIGN KEY ("ClassId") REFERENCES "ClassSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Classes" ADD CONSTRAINT "FK_Classes_Courses" FOREIGN KEY ("CourseId") REFERENCES "Courses" ("Id");
ALTER TABLE "Classes" ADD CONSTRAINT "FK_Classes_Levels" FOREIGN KEY ("LevelId") REFERENCES "Levels" ("Id");
ALTER TABLE "Classes" ADD CONSTRAINT "FK_Classes_Majors" FOREIGN KEY ("MajorId") REFERENCES "Majors" ("Id");
ALTER TABLE "ClassLessons" ADD CONSTRAINT "FK_ClassLessons_ClassSubjects" FOREIGN KEY ("ClassId") REFERENCES "ClassSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ClassManagers" ADD CONSTRAINT "FK_ClassManagers_ClassSubjects" FOREIGN KEY ("ClassId") REFERENCES "ClassSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ClassManagers" ADD CONSTRAINT "FK_ClassManagers_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ClassPostAttachments" ADD CONSTRAINT "FK_Attach_Posts" FOREIGN KEY ("PostId") REFERENCES "ClassPosts" ("Id");
ALTER TABLE "ClassPostComments" ADD CONSTRAINT "FK_Comments_Parent" FOREIGN KEY ("ParentId") REFERENCES "ClassPostComments" ("Id");
ALTER TABLE "ClassPostComments" ADD CONSTRAINT "FK_Comments_Posts" FOREIGN KEY ("PostId") REFERENCES "ClassPosts" ("Id");
ALTER TABLE "ClassPostComments" ADD CONSTRAINT "FK_Comments_Users" FOREIGN KEY ("UserId") REFERENCES "Users" ("UserId");
ALTER TABLE "ClassPostLinks" ADD CONSTRAINT "FK_Links_Posts" FOREIGN KEY ("PostId") REFERENCES "ClassPosts" ("Id");
ALTER TABLE "ClassPosts" ADD CONSTRAINT "FK_ClassPosts_ClassSubjects" FOREIGN KEY ("ClassId") REFERENCES "ClassSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ClassPosts" ADD CONSTRAINT "FK_ClassPostsUsers" FOREIGN KEY ("UserId") REFERENCES "Users" ("UserId");
ALTER TABLE "ClassPostViews" ADD CONSTRAINT "FK_ClassPostViews_ClassPosts" FOREIGN KEY ("PostId") REFERENCES "ClassPosts" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ClassPostViews" ADD CONSTRAINT "FK_ClassPostViews_Users" FOREIGN KEY ("UserId") REFERENCES "Users" ("UserId") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ClassStudentGroups" ADD CONSTRAINT "FK_ClassGroups_ClassSubjects" FOREIGN KEY ("ClassId") REFERENCES "ClassSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ClassStudents" ADD CONSTRAINT "FK_ClassStudents_ClassSubjects" FOREIGN KEY ("ClassId") REFERENCES "ClassSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ClassStudents" ADD CONSTRAINT "FK_ClassStudents_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "CloScoreTypes" ADD CONSTRAINT "FK_CloScoreTypes_ScoreTypes" FOREIGN KEY ("ScoreTypeId") REFERENCES "ScoreTypes" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "CloScoreTypes" ADD CONSTRAINT "FK_CloScoreTypes_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ConductScores" ADD CONSTRAINT "FK_ConductScores_ConductScores" FOREIGN KEY ("YearId") REFERENCES "Years" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ConductScores" ADD CONSTRAINT "FK_ConductScores_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "CourseLearningOutcomes" ADD CONSTRAINT "FK_CourseLearningOutcomes_CourseLearningOutcomeSets" FOREIGN KEY ("SetId") REFERENCES "CourseLearningOutcomeSets" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "CourseLearningOutcomeSets" ADD CONSTRAINT "FK_CourseLearningOutcomes_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Courses" ADD CONSTRAINT "FK_Courses_Departments" FOREIGN KEY ("DepartmentId") REFERENCES "Departments" ("Id");
ALTER TABLE "Courses" ADD CONSTRAINT "FK_Courses_Years" FOREIGN KEY ("YearId") REFERENCES "Years" ("Id");
ALTER TABLE "DocumentContents" ADD CONSTRAINT "FK_DocumentContents_Documents" FOREIGN KEY ("DocumentId") REFERENCES "Documents" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Documents" ADD CONSTRAINT "FK_Documents_Folders" FOREIGN KEY ("FolderId") REFERENCES "Folders" ("Id");
ALTER TABLE "Documents" ADD CONSTRAINT "FK_Documents_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id");
ALTER TABLE "ExamManagers" ADD CONSTRAINT "FK_ExamManager_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ExamManagers" ADD CONSTRAINT "FK_ExamManagers_Exams" FOREIGN KEY ("ExamId") REFERENCES "Exams" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Exams" ADD CONSTRAINT "FK_Exams_Staffs" FOREIGN KEY ("CreatorId") REFERENCES "Staffs" ("Id");
ALTER TABLE "Exams" ADD CONSTRAINT "FK_Exams_Years" FOREIGN KEY ("YearId") REFERENCES "Years" ("Id");
ALTER TABLE "ExamSchedules" ADD CONSTRAINT "FK_ExamSchedules_ExamRooms" FOREIGN KEY ("RoomId") REFERENCES "ExamRooms" ("Id");
ALTER TABLE "ExamSchedules" ADD CONSTRAINT "FK_ExamSchedules_ExamSlots" FOREIGN KEY ("SlotId") REFERENCES "ExamSlots" ("Id");
ALTER TABLE "ExamSchedules" ADD CONSTRAINT "FK_ExamSchedules_ExamSubjects" FOREIGN KEY ("ExamSubjectId") REFERENCES "ExamSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ExamSlots" ADD CONSTRAINT "FK_ExanSlots_Exams" FOREIGN KEY ("ExamId") REFERENCES "Exams" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ExamSubjectAssignments" ADD CONSTRAINT "FK_ESA_Creator" FOREIGN KEY ("CreatorId") REFERENCES "Staffs" ("Id");
ALTER TABLE "ExamSubjectAssignments" ADD CONSTRAINT "FK_ESA_ExamSubject" FOREIGN KEY ("ExamSubjectId") REFERENCES "ExamSubjects" ("Id");
ALTER TABLE "ExamSubjectAssignments" ADD CONSTRAINT "FK_ESA_HeadApprover" FOREIGN KEY ("HeadApproverStaffId") REFERENCES "Staffs" ("Id");
ALTER TABLE "ExamSubjectAssignments" ADD CONSTRAINT "FK_ESA_QuestionBank" FOREIGN KEY ("QuestionBankId") REFERENCES "QuestionBanks" ("Id");
ALTER TABLE "ExamSubjectAssignments" ADD CONSTRAINT "FK_ESA_Staff" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id");
ALTER TABLE "ExamSubjectAssignments" ADD CONSTRAINT "FK_ESA_TestGenerator" FOREIGN KEY ("TestGeneratorId") REFERENCES "TestGenerators" ("Id");
ALTER TABLE "ExamSubjectAssignmentTestGenerators" ADD CONSTRAINT "FK_ESATG_Assignment" FOREIGN KEY ("ExamSubjectAssignmentId") REFERENCES "ExamSubjectAssignments" ("Id") ON DELETE CASCADE;
ALTER TABLE "ExamSubjectAssignmentTestGenerators" ADD CONSTRAINT "FK_ESATG_Creator" FOREIGN KEY ("CreatorId") REFERENCES "Staffs" ("Id");
ALTER TABLE "ExamSubjectAssignmentTestGenerators" ADD CONSTRAINT "FK_ESATG_HeadApprover" FOREIGN KEY ("HeadApproverStaffId") REFERENCES "Staffs" ("Id");
ALTER TABLE "ExamSubjectAssignmentTestGenerators" ADD CONSTRAINT "FK_ESATG_TestGenerator" FOREIGN KEY ("TestGeneratorId") REFERENCES "TestGenerators" ("Id");
ALTER TABLE "ExamSubjectClos" ADD CONSTRAINT "FK_ExamSubjectClos_ExamSubjects" FOREIGN KEY ("ExamSubjectId") REFERENCES "ExamSubjects" ("Id") ON DELETE CASCADE;
ALTER TABLE "ExamSubjectInfo" ADD CONSTRAINT "FK_ExamSubjectInfo_ExamSubjects" FOREIGN KEY ("ExamSubjectId") REFERENCES "ExamSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ExamSubjectManagers" ADD CONSTRAINT "FK_ExamSubjectManager_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ExamSubjectManagers" ADD CONSTRAINT "FK_ExamSubjectManagers_ExamSubjects" FOREIGN KEY ("ExamSubjectId") REFERENCES "ExamSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ExamSubjectNetworks" ADD CONSTRAINT "FK_ExamSubjectNetworks_ExamSubjects" FOREIGN KEY ("ExamSubjectId") REFERENCES "ExamSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ExamSubjectNetworks" ADD CONSTRAINT "FK_ExamSubjectNetworks_Networks" FOREIGN KEY ("NetworkId") REFERENCES "Networks" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ExamSubjects" ADD CONSTRAINT "FK_ExamSubjects_Courses" FOREIGN KEY ("CourseId") REFERENCES "Courses" ("Id");
ALTER TABLE "ExamSubjects" ADD CONSTRAINT "FK_ExamSubjects_Exams" FOREIGN KEY ("ExamId") REFERENCES "Exams" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ExamSubjects" ADD CONSTRAINT "FK_ExamSubjects_Levels" FOREIGN KEY ("LevelId") REFERENCES "Levels" ("Id");
ALTER TABLE "ExamSubjects" ADD CONSTRAINT "FK_ExamSubjects_Majors" FOREIGN KEY ("MajorId") REFERENCES "Majors" ("Id");
ALTER TABLE "ExamSubjects" ADD CONSTRAINT "FK_ExamSubjects_Staffs" FOREIGN KEY ("CreatorId") REFERENCES "Staffs" ("Id");
ALTER TABLE "ExamSubjects" ADD CONSTRAINT "FK_ExamSubjects_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id");
ALTER TABLE "ExamSupervisors" ADD CONSTRAINT "FK_ExamSupervisors_ExamSchedules" FOREIGN KEY ("ExamScheduleId") REFERENCES "ExamSchedules" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ExamSupervisors" ADD CONSTRAINT "FK_ExamSupervisors_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Faces" ADD CONSTRAINT "FK_Faces_Students" FOREIGN KEY ("OwnerId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "LearningJournalCommentAttachments" ADD CONSTRAINT "FK_LJCA_Comments" FOREIGN KEY ("CommentId") REFERENCES "LearningJournalComments" ("Id");
ALTER TABLE "LearningJournalCommentMentions" ADD CONSTRAINT "FK_LJCM_Comments" FOREIGN KEY ("CommentId") REFERENCES "LearningJournalComments" ("Id");
ALTER TABLE "LearningJournalCommentReactions" ADD CONSTRAINT "FK_LJCR_Comments" FOREIGN KEY ("CommentId") REFERENCES "LearningJournalComments" ("Id");
ALTER TABLE "LearningJournalComments" ADD CONSTRAINT "FK_LJC_Entries" FOREIGN KEY ("EntryId") REFERENCES "LearningJournalEntries" ("Id");
ALTER TABLE "LearningJournalComments" ADD CONSTRAINT "FK_LJC_Parent" FOREIGN KEY ("ParentCommentId") REFERENCES "LearningJournalComments" ("Id");
ALTER TABLE "LearningJournalComments" ADD CONSTRAINT "FK_LJC_Root" FOREIGN KEY ("RootCommentId") REFERENCES "LearningJournalComments" ("Id");
ALTER TABLE "LearningJournalEntries" ADD CONSTRAINT "FK_LJE_ClassSubjects" FOREIGN KEY ("ClassSubjectId") REFERENCES "ClassSubjects" ("Id");
ALTER TABLE "LearningJournalEntries" ADD CONSTRAINT "FK_LJE_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id");
ALTER TABLE "LearningJournalEntries" ADD CONSTRAINT "FK_LJE_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id");
ALTER TABLE "LearningJournalEntries" ADD CONSTRAINT "FK_LJE_Types" FOREIGN KEY ("TypeId") REFERENCES "LearningJournalTypes" ("Id");
ALTER TABLE "LearningJournalEvidences" ADD CONSTRAINT "FK_LJEv_Entries" FOREIGN KEY ("EntryId") REFERENCES "LearningJournalEntries" ("Id");
ALTER TABLE "LearningJournalReviews" ADD CONSTRAINT "FK_LJR_Entries" FOREIGN KEY ("EntryId") REFERENCES "LearningJournalEntries" ("Id");
ALTER TABLE "LearningJournalTypes" ADD CONSTRAINT "FK_LJT_ClassSubjects" FOREIGN KEY ("ClassSubjectId") REFERENCES "ClassSubjects" ("Id");
ALTER TABLE "LearningJournalTypes" ADD CONSTRAINT "FK_LJT_ParentType" FOREIGN KEY ("ParentTypeId") REFERENCES "LearningJournalTypes" ("Id");
ALTER TABLE "LearningJournalTypes" ADD CONSTRAINT "FK_LJT_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id");
ALTER TABLE "LearningJournalTypeSettings" ADD CONSTRAINT "FK_LJTS_ClassSubjects" FOREIGN KEY ("ClassSubjectId") REFERENCES "ClassSubjects" ("Id");
ALTER TABLE "LearningJournalTypeSettings" ADD CONSTRAINT "FK_LJTS_Types" FOREIGN KEY ("TypeId") REFERENCES "LearningJournalTypes" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "LessonComments" ADD CONSTRAINT "FK_LessonComments_ClassLessons" FOREIGN KEY ("LessonId") REFERENCES "ClassLessons" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "LessonComments" ADD CONSTRAINT "FK_LessonComments_Users" FOREIGN KEY ("UserId") REFERENCES "Users" ("UserId") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "LessonEmotions" ADD CONSTRAINT "FK_LessonEmotions_ClassLessons" FOREIGN KEY ("LessonId") REFERENCES "ClassLessons" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Majors" ADD CONSTRAINT "FK_Majors_Departments" FOREIGN KEY ("DepartmentId") REFERENCES "Departments" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "MarkDetails" ADD CONSTRAINT "FK_MarkDetails_Marks" FOREIGN KEY ("MarkId") REFERENCES "Marks" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "MarkDetails" ADD CONSTRAINT "FK_MarkDetails_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id");
ALTER TABLE "MarkManagers" ADD CONSTRAINT "FK_MarkManagers_Marks" FOREIGN KEY ("MarkId") REFERENCES "Marks" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "MarkManagers" ADD CONSTRAINT "FK_MarkManagers_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "MarkPaperDetails" ADD CONSTRAINT "FK_MarkPaperDetails_MarkPapers" FOREIGN KEY ("MarkPaperId") REFERENCES "MarkPapers" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "MarkPapers" ADD CONSTRAINT "FK_MarkPapers_Candidates" FOREIGN KEY ("CandidateId") REFERENCES "Candidates" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "MarkPapers" ADD CONSTRAINT "FK_MarkPapers_Marks" FOREIGN KEY ("MarkId") REFERENCES "Marks" ("Id");
ALTER TABLE "MarkPapers" ADD CONSTRAINT "FK_MarkPapers_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id");
ALTER TABLE "MarkRooms" ADD CONSTRAINT "FK_MarkRooms_ExamSubjects" FOREIGN KEY ("ExamSubjectId") REFERENCES "ExamSubjects" ("Id");
ALTER TABLE "MarkRooms" ADD CONSTRAINT "FK_MarkRooms_Marks" FOREIGN KEY ("MarkId") REFERENCES "Marks" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "MarkRooms" ADD CONSTRAINT "FK_MarkRooms_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Marks" ADD CONSTRAINT "FK_Marks_ExamSubjects" FOREIGN KEY ("ExamSubjectId") REFERENCES "ExamSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Marks" ADD CONSTRAINT "FK_Marks_Staffs" FOREIGN KEY ("ManagerId") REFERENCES "Staffs" ("Id");
ALTER TABLE "MarkSlots" ADD CONSTRAINT "FK_MarkSlots_ExamSlots" FOREIGN KEY ("SlotId") REFERENCES "ExamSlots" ("Id");
ALTER TABLE "MarkSlots" ADD CONSTRAINT "FK_MarkSlots_Marks" FOREIGN KEY ("MarkId") REFERENCES "Marks" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "NotificationDevices" ADD CONSTRAINT "FK_NotificationDevices_Users" FOREIGN KEY ("UserId") REFERENCES "Users" ("UserId") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "OtherScores" ADD CONSTRAINT "FK_OtherScores_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "OtherScores" ADD CONSTRAINT "FK_OtherScores_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "OutcomeMappings" ADD CONSTRAINT "FK_OutcomeMappings_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "OutcomeMappings" ADD CONSTRAINT "FK_OutcomeMappings_TrainingPrograms" FOREIGN KEY ("ProgramId") REFERENCES "TrainingPrograms" ("Id");
ALTER TABLE "OutcomeStudents" ADD CONSTRAINT "FK_OutcomeStudents_OutcomeAssements" FOREIGN KEY ("AssessmentId") REFERENCES "OutcomeAssessments" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "OutcomeStudents" ADD CONSTRAINT "FK_OutcomeStudents_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Paragraphs" ADD CONSTRAINT "FK_Paragraphs_Documents" FOREIGN KEY ("DocumentId") REFERENCES "Documents" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PostViews" ADD CONSTRAINT "FK_PostViews_Posts" FOREIGN KEY ("PostId") REFERENCES "Posts" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PracticeAnswers" ADD CONSTRAINT "FK_PracticeAnswers_PracticeSessions" FOREIGN KEY ("SessionId") REFERENCES "PracticeSessions" ("Id") ON DELETE CASCADE;
ALTER TABLE "PracticeAnswers" ADD CONSTRAINT "FK_PracticeAnswers_Questions" FOREIGN KEY ("QuestionId") REFERENCES "Questions" ("Id");
ALTER TABLE "PracticeSessions" ADD CONSTRAINT "FK_PracticeSessions_ClassActivities" FOREIGN KEY ("ActivityId") REFERENCES "ClassActivities" ("Id");
ALTER TABLE "PracticeSessions" ADD CONSTRAINT "FK_PracticeSessions_ClassSubjects" FOREIGN KEY ("ClassId") REFERENCES "ClassSubjects" ("Id");
ALTER TABLE "PracticeSessions" ADD CONSTRAINT "FK_PracticeSessions_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id");
ALTER TABLE "ProgramDetails" ADD CONSTRAINT "FK_ProgramDetails_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ProgramDetails" ADD CONSTRAINT "FK_ProgramDetails_TrainingPrograms" FOREIGN KEY ("ProgramId") REFERENCES "TrainingPrograms" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ProgramOutcomes" ADD CONSTRAINT "FK_ProgramOutcomes_TrainingPrograms" FOREIGN KEY ("ProgramId") REFERENCES "TrainingPrograms" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ProgramUsages" ADD CONSTRAINT "FK_ProgramUsages_TrainingPrograms" FOREIGN KEY ("ProgramId") REFERENCES "TrainingPrograms" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionAssignmentComments" ADD CONSTRAINT "FK_QAComments_Assignments" FOREIGN KEY ("AssignmentId") REFERENCES "QuestionBankAssignments" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionAssignmentComments" ADD CONSTRAINT "FK_QAComments_Parent" FOREIGN KEY ("ParentId") REFERENCES "QuestionAssignmentComments" ("Id");
ALTER TABLE "QuestionAssignmentComments" ADD CONSTRAINT "FK_QAComments_QuestionAssignments" FOREIGN KEY ("QuestionAssignmentId") REFERENCES "QuestionAssignments" ("Id");
ALTER TABLE "QuestionAssignmentReviewers" ADD CONSTRAINT "FK_QAReviewers_Assignments" FOREIGN KEY ("AssignmentId") REFERENCES "QuestionBankAssignments" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionAssignmentReviewers" ADD CONSTRAINT "FK_QAReviewers_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id");
ALTER TABLE "QuestionAssignmentReviews" ADD CONSTRAINT "FK_QAReviews_Assignments" FOREIGN KEY ("AssignmentId") REFERENCES "QuestionBankAssignments" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionAssignmentReviews" ADD CONSTRAINT "FK_QAReviews_QuestionAssignments" FOREIGN KEY ("QuestionAssignmentId") REFERENCES "QuestionAssignments" ("Id");
ALTER TABLE "QuestionAssignmentReviews" ADD CONSTRAINT "FK_QAReviews_Staffs" FOREIGN KEY ("ReviewerId") REFERENCES "Staffs" ("Id");
ALTER TABLE "QuestionAssignments" ADD CONSTRAINT "FK_QuestionAssignments_QuestionBankAssignments" FOREIGN KEY ("AssignmentId") REFERENCES "QuestionBankAssignments" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionAssignments" ADD CONSTRAINT "FK_QuestionAssignments_Questions" FOREIGN KEY ("QuestionId") REFERENCES "Questions" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionAssignments" ADD CONSTRAINT "FK_QuestionAssignments_TargetReplace" FOREIGN KEY ("TargetReplaceId") REFERENCES "Questions" ("Id");
ALTER TABLE "QuestionAttachments" ADD CONSTRAINT "FK_QuestionAttachments_Questions" FOREIGN KEY ("QuestionId") REFERENCES "Questions" ("Id");
ALTER TABLE "QuestionBankAssignments" ADD CONSTRAINT "FK_QuestionBankAssignments_QuestionBanks" FOREIGN KEY ("QuestionBankId") REFERENCES "QuestionBanks" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionBankAssignments" ADD CONSTRAINT "FK_QuestionBankAssignments_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionBankAssignmentStaffs" ADD CONSTRAINT "FK_QuestionBankAssignmentStaffs_QuestionBankAssignments" FOREIGN KEY ("AssignmentId") REFERENCES "QuestionBankAssignments" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionBankAssignmentStaffs" ADD CONSTRAINT "FK_QuestionBankAssignmentStaffs_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id");
ALTER TABLE "QuestionBankClo" ADD CONSTRAINT "FK_QuestionBankClo_QuestionBanks" FOREIGN KEY ("QuestionBankId") REFERENCES "QuestionBanks" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionBankDocuments" ADD CONSTRAINT "FK_QuestionBankDocuments_Documents" FOREIGN KEY ("DocumentId") REFERENCES "Documents" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionBankDocuments" ADD CONSTRAINT "FK_QuestionBankDocuments_QuestionBanks" FOREIGN KEY ("QuestionBankId") REFERENCES "QuestionBanks" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionBanks" ADD CONSTRAINT "FK_QuestionBanks_Departments" FOREIGN KEY ("DepartmentId") REFERENCES "Departments" ("Id");
ALTER TABLE "QuestionBanks" ADD CONSTRAINT "FK_QuestionBanks_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id");
ALTER TABLE "QuestionBanks" ADD CONSTRAINT "FK_QuestionBanks_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id");
ALTER TABLE "QuestionBankShares" ADD CONSTRAINT "FK_QuestionBankShares_QuestionBanks" FOREIGN KEY ("QuestionBankId") REFERENCES "QuestionBanks" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionCalibrations" ADD CONSTRAINT "FK_QuestionCalibrations_Questions" FOREIGN KEY ("QuestionId") REFERENCES "Questions" ("Id") ON DELETE CASCADE;
ALTER TABLE "QuestionCellAssignments" ADD CONSTRAINT "FK_QuestionCellAssignments_QuestionBankAssignments" FOREIGN KEY ("RequestId") REFERENCES "QuestionBankAssignments" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionCellAssignments" ADD CONSTRAINT "FK_QuestionCellAssignments_QuestionLevels" FOREIGN KEY ("LevelId") REFERENCES "QuestionLevels" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionCellAssignments" ADD CONSTRAINT "FK_QuestionCellAssignments_SubjectDetails" FOREIGN KEY ("DetailId") REFERENCES "SubjectDetails" ("Id");
ALTER TABLE "QuestionClo" ADD CONSTRAINT "FK_QuestionClo_Questions" FOREIGN KEY ("QuestionId") REFERENCES "Questions" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionContents" ADD CONSTRAINT "FK_QuestionContents_Questions" FOREIGN KEY ("QuestionId") REFERENCES "Questions" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionReviewerDecisionLogs" ADD CONSTRAINT "FK_QRDecisionLogs_QA" FOREIGN KEY ("QuestionAssignmentId") REFERENCES "QuestionAssignments" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionReviewerDecisionLogs" ADD CONSTRAINT "FK_QRDecisionLogs_Reviewer" FOREIGN KEY ("ReviewerId") REFERENCES "QuestionAssignmentReviewers" ("Id");
ALTER TABLE "QuestionReviewerDecisionLogs" ADD CONSTRAINT "FK_QRDecisionLogs_Staff" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id");
ALTER TABLE "QuestionReviewerDecisions" ADD CONSTRAINT "FK_QRDecisions_QuestionAssignments" FOREIGN KEY ("QuestionAssignmentId") REFERENCES "QuestionAssignments" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionReviewerDecisions" ADD CONSTRAINT "FK_QRDecisions_Reviewers" FOREIGN KEY ("ReviewerId") REFERENCES "QuestionAssignmentReviewers" ("Id");
ALTER TABLE "Questions" ADD CONSTRAINT "FK_Questions_QuestionBanks" FOREIGN KEY ("QuestionBankId") REFERENCES "QuestionBanks" ("Id");
ALTER TABLE "Questions" ADD CONSTRAINT "FK_Questions_QuestionLevels" FOREIGN KEY ("LevelId") REFERENCES "QuestionLevels" ("Id");
ALTER TABLE "Questions" ADD CONSTRAINT "FK_Questions_Questions" FOREIGN KEY ("ParentId") REFERENCES "Questions" ("Id");
ALTER TABLE "Questions" ADD CONSTRAINT "FK_Questions_Staffs" FOREIGN KEY ("CreateStaffId") REFERENCES "Staffs" ("Id");
ALTER TABLE "Questions" ADD CONSTRAINT "FK_Questions_SubjectDetails" FOREIGN KEY ("SubjectDetailId") REFERENCES "SubjectDetails" ("Id");
ALTER TABLE "Questions" ADD CONSTRAINT "FK_Questions_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "QuestionUseRecords" ADD CONSTRAINT "FK_QuestionUseRecords_Questions" FOREIGN KEY ("QuestionId") REFERENCES "Questions" ("Id");
ALTER TABLE "Quizzes" ADD CONSTRAINT "FK_Quizzes_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "RemarkRequests" ADD CONSTRAINT "FK_RemarkRequests_Candidates" FOREIGN KEY ("CandidateId") REFERENCES "Candidates" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "RemarkRequests" ADD CONSTRAINT "FK_RemarkRequests_Marks1" FOREIGN KEY ("MarkId") REFERENCES "Marks" ("Id");
ALTER TABLE "RoomDevices" ADD CONSTRAINT "FK_RoomDevices_ExamRooms" FOREIGN KEY ("RoomId") REFERENCES "ExamRooms" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "SharedFolders" ADD CONSTRAINT "FK_SharedFolders_Folders" FOREIGN KEY ("FolderId") REFERENCES "Folders" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "SharedLectures" ADD CONSTRAINT "FK_SharedLectures_ClassSubjects" FOREIGN KEY ("ClassId") REFERENCES "ClassSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "SharedLectures" ADD CONSTRAINT "FK_SharedLectures_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "SharedTests" ADD CONSTRAINT "FK_SharedTests_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "SharedTests" ADD CONSTRAINT "FK_SharedTests_TestGenerators" FOREIGN KEY ("TestGeneratorId") REFERENCES "TestGenerators" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "SharedTestStructures" ADD CONSTRAINT "FK_SharedTestStructures_TestStructures" FOREIGN KEY ("TestStructureId") REFERENCES "TestStructures" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
CREATE UNIQUE INDEX "IX_SharedTestStructures_TestStructureId_Target" ON "SharedTestStructures" ("TestStructureId", "TargetType", "TargetId");
ALTER TABLE "StaffDepts" ADD CONSTRAINT "FK_StaffDepts_Departments" FOREIGN KEY ("DepartmentId") REFERENCES "Departments" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StaffDepts" ADD CONSTRAINT "FK_StaffDepts_Positions" FOREIGN KEY ("PositionId") REFERENCES "Positions" ("Id");
ALTER TABLE "StaffDepts" ADD CONSTRAINT "FK_StaffDepts_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StaffExternalAccounts" ADD CONSTRAINT "FK_StaffExternalAccounts_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Staffs" ADD CONSTRAINT "FK_Staffs_Users" FOREIGN KEY ("UserId") REFERENCES "Users" ("UserId");
ALTER TABLE "StudentActivity" ADD CONSTRAINT "FK_StudentActivity_ClassActivities" FOREIGN KEY ("ActivityId") REFERENCES "ClassActivities" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentActivity" ADD CONSTRAINT "FK_StudentActivity_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentActivityComments" ADD CONSTRAINT "FK_StudentActivityComments_ClassActivities" FOREIGN KEY ("ActivityId") REFERENCES "ClassActivities" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentActivityComments" ADD CONSTRAINT "FK_StudentActivityComments_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentActivityData" ADD CONSTRAINT "FK_StudentActivityData_StudentActivity" FOREIGN KEY ("StudentActivityId") REFERENCES "StudentActivity" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentActivityDataHistory" ADD CONSTRAINT "FK_StudentActivityDataHistory_StudentActivity" FOREIGN KEY ("StudentActivityId") REFERENCES "StudentActivity" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentAttendances" ADD CONSTRAINT "FK_StudentAttendances_Attendances" FOREIGN KEY ("AttendanceId") REFERENCES "Attendances" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentAttendances" ADD CONSTRAINT "FK_StudentAttendances_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentClo" ADD CONSTRAINT "FK_CloStudents_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentCloScoreTypes" ADD CONSTRAINT "FK_StudentCloScoreTypes_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentCloScoreTypes" ADD CONSTRAINT "FK_StudentCloScoreTypes_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentExternalAccounts" ADD CONSTRAINT "FK_StudentExternalAccounts_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentLessons" ADD CONSTRAINT "FK_StudentLessons_ClassLessons" FOREIGN KEY ("LessonId") REFERENCES "ClassLessons" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentLessons" ADD CONSTRAINT "FK_StudentLessons_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentMajors" ADD CONSTRAINT "FK_StudentMajors_Classes" FOREIGN KEY ("ClassId") REFERENCES "Classes" ("Id");
ALTER TABLE "StudentMajors" ADD CONSTRAINT "FK_StudentMajors_Courses" FOREIGN KEY ("CourseId") REFERENCES "Courses" ("Id");
ALTER TABLE "StudentMajors" ADD CONSTRAINT "FK_StudentMajors_Levels" FOREIGN KEY ("LevelId") REFERENCES "Levels" ("Id");
ALTER TABLE "StudentMajors" ADD CONSTRAINT "FK_StudentMajors_Majors" FOREIGN KEY ("MajorId") REFERENCES "Majors" ("Id");
ALTER TABLE "StudentMajors" ADD CONSTRAINT "FK_StudentMajors_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentPlo" ADD CONSTRAINT "FK_StudentPlo_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentPlo" ADD CONSTRAINT "FK_StudentPlo_TrainingPrograms" FOREIGN KEY ("ProgramId") REFERENCES "TrainingPrograms" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentQuizAnswers" ADD CONSTRAINT "FK_StudentQuizAnswers_ClassActivities" FOREIGN KEY ("ActivityId") REFERENCES "ClassActivities" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentQuizAnswers" ADD CONSTRAINT "FK_StudentQuizAnswers_Questions" FOREIGN KEY ("QuestionId") REFERENCES "Questions" ("Id");
ALTER TABLE "StudentQuizAnswers" ADD CONSTRAINT "FK_StudentQuizAnswers_Quizzes" FOREIGN KEY ("QuizId") REFERENCES "Quizzes" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "StudentQuizAnswers" ADD CONSTRAINT "FK_StudentQuizAnswers_Students" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Students" ADD CONSTRAINT "FK_Students_Departments" FOREIGN KEY ("DepartmentId") REFERENCES "Departments" ("Id");
ALTER TABLE "Students" ADD CONSTRAINT "FK_Students_Users" FOREIGN KEY ("UserId") REFERENCES "Users" ("UserId");
ALTER TABLE "SubjectDetailPerms" ADD CONSTRAINT "FK_SubjectDetailPerms_QuestionBankShares" FOREIGN KEY ("QuestionBankShareId") REFERENCES "QuestionBankShares" ("Id");
ALTER TABLE "SubjectDetailPerms" ADD CONSTRAINT "FK_SubjectDetailPerms_SubjectDetails" FOREIGN KEY ("DetailId") REFERENCES "SubjectDetails" ("Id");
ALTER TABLE "SubjectDetails" ADD CONSTRAINT "FK_SubjectDetails_QuestionBanks" FOREIGN KEY ("QuestionBankId") REFERENCES "QuestionBanks" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "SubjectManagers" ADD CONSTRAINT "FK_SubjectManagers_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "SubjectManagers" ADD CONSTRAINT "FK_SubjectManagers_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Subjects" ADD CONSTRAINT "FK_Subjects_Departments" FOREIGN KEY ("DepartmentId") REFERENCES "Departments" ("Id");
ALTER TABLE "SubjectScoreTypes" ADD CONSTRAINT "FK_SubjectScoreTypes_ScoreTypes" FOREIGN KEY ("ScoreTypeId") REFERENCES "ScoreTypes" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "SubjectScoreTypes" ADD CONSTRAINT "FK_SubjectScoreTypes_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "SubjectTests" ADD CONSTRAINT "FK_SubjectTests_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id");
ALTER TABLE "SubjectTests" ADD CONSTRAINT "FK_SubjectTests_TestGenerators" FOREIGN KEY ("TestGeneratorId") REFERENCES "TestGenerators" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "SupervisorPasswordHistory" ADD CONSTRAINT "FK_SupervisorPasswordHistory_ExamSubjects" FOREIGN KEY ("ExamSubjectId") REFERENCES "ExamSubjects" ("Id") ON DELETE CASCADE;
ALTER TABLE "SupervisorPasswordHistory" ADD CONSTRAINT "FK_SupervisorPasswordHistory_Staffs" FOREIGN KEY ("CreatorId") REFERENCES "Staffs" ("Id");
ALTER TABLE "SurveyAnswers" ADD CONSTRAINT "FK_SurveyAnswer_Survey" FOREIGN KEY ("SurveyId") REFERENCES "Survey" ("Id");
ALTER TABLE "SurveyAnswers" ADD CONSTRAINT "FK_SurveyAnswers_SurveyResponses" FOREIGN KEY ("ResponseId") REFERENCES "SurveyResponses" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "SurveyResponses" ADD CONSTRAINT "FK_SurveyResponse_Survey" FOREIGN KEY ("SurveyId") REFERENCES "Survey" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "TestAnalysis" ADD CONSTRAINT "FK_TestAnalysis_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "TestAttachments" ADD CONSTRAINT "FK_TestAttachments_Tests" FOREIGN KEY ("TestId") REFERENCES "Tests" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "TestComments" ADD CONSTRAINT "FK_TestComments_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "TestComments" ADD CONSTRAINT "FK_TestComments_TestGenerators" FOREIGN KEY ("TestGeneratorId") REFERENCES "TestGenerators" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "TestFlows" ADD CONSTRAINT "FK_TestFlows_StaffsFrom" FOREIGN KEY ("FromStaffId") REFERENCES "Staffs" ("Id");
ALTER TABLE "TestFlows" ADD CONSTRAINT "FK_TestFlows_StaffsTo" FOREIGN KEY ("ToStaffId") REFERENCES "Staffs" ("Id");
ALTER TABLE "TestFlows" ADD CONSTRAINT "FK_TestFlows_TestGenerators" FOREIGN KEY ("TestGeneratorId") REFERENCES "TestGenerators" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "TestGeneratorFiles" ADD CONSTRAINT "FK_TestGeneratorFiles_TestGenerators" FOREIGN KEY ("TestGeneratorId") REFERENCES "TestGenerators" ("Id") ON DELETE CASCADE;
ALTER TABLE "TestGenerators" ADD CONSTRAINT "FK_TestGenerators_Departments" FOREIGN KEY ("DepartmentId") REFERENCES "Departments" ("Id");
ALTER TABLE "TestGenerators" ADD CONSTRAINT "FK_TestGenerators_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id");
ALTER TABLE "TestGenerators" ADD CONSTRAINT "FK_TestGenerators_Subjects" FOREIGN KEY ("SubjectId") REFERENCES "Subjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "TestGenerators" ADD CONSTRAINT "FK_TestGenerators_TestTemplates" FOREIGN KEY ("TemplateId") REFERENCES "TestTemplates" ("Id");
ALTER TABLE "TestInCollections" ADD CONSTRAINT "FK_TestInCollections_TestCollections" FOREIGN KEY ("TestCollectionId") REFERENCES "TestCollections" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "TestInCollections" ADD CONSTRAINT "FK_TestInCollections_TestGenerators" FOREIGN KEY ("TestId") REFERENCES "TestGenerators" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "TestParts" ADD CONSTRAINT "FK_TestParts_TestStructures" FOREIGN KEY ("TestStructId") REFERENCES "TestStructures" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "TestQuestions" ADD CONSTRAINT "FK_TestQuestions_Questions" FOREIGN KEY ("QuestionId") REFERENCES "Questions" ("Id");
ALTER TABLE "TestQuestions" ADD CONSTRAINT "FK_TestQuestions_Tests" FOREIGN KEY ("TestId") REFERENCES "Tests" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Tests" ADD CONSTRAINT "FK_Tests_TestGenerators" FOREIGN KEY ("TestGeneratorId") REFERENCES "TestGenerators" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Tests" ADD CONSTRAINT "FK_Tests_Tests" FOREIGN KEY ("ParentId") REFERENCES "Tests" ("Id");
ALTER TABLE "TestStructureFiles" ADD CONSTRAINT "FK_TestStructureFiles_TestStructures" FOREIGN KEY ("TestStructureId") REFERENCES "TestStructures" ("Id") ON DELETE CASCADE;
ALTER TABLE "TestStructures" ADD CONSTRAINT "FK_TestStructures_QuestionBanks" FOREIGN KEY ("QuestionBankId") REFERENCES "QuestionBanks" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "TestStructures" ADD CONSTRAINT "FK_TestStructures_Staffs" FOREIGN KEY ("StaffId") REFERENCES "Staffs" ("Id");
ALTER TABLE "TestStructures" ADD CONSTRAINT "FK_TestStructures_TestTemplates" FOREIGN KEY ("TemplateId") REFERENCES "TestTemplates" ("Id");
ALTER TABLE "TestUsages" ADD CONSTRAINT "FK_TestUsages_ExamSubjects" FOREIGN KEY ("ExamSubjectId") REFERENCES "ExamSubjects" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "TestUsages" ADD CONSTRAINT "FK_TestUsages_TestGenerators" FOREIGN KEY ("TestGeneratorId") REFERENCES "TestGenerators" ("Id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "TrainingPrograms" ADD CONSTRAINT "FK_TrainingPrograms_Majors" FOREIGN KEY ("MajorId") REFERENCES "Majors" ("Id");
ALTER TABLE "TrainingPrograms" ADD CONSTRAINT "FK_TrainingPrograms_Years" FOREIGN KEY ("YearId") REFERENCES "Years" ("Id");
ALTER TABLE "UserRoles" ADD CONSTRAINT "FK_UserRoles_Roles" FOREIGN KEY ("RoleId") REFERENCES "Roles" ("RoleId") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "UserRoles" ADD CONSTRAINT "FK_UserRoles_Users" FOREIGN KEY ("UserId") REFERENCES "Users" ("UserId") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Users" ADD CONSTRAINT "FK_Users_Devices" FOREIGN KEY ("DeviceId") REFERENCES "Devices" ("Id");
