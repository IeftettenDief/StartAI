-- CreateEnum
CREATE TYPE "AccountType" AS ENUM ('freemium', 'premium', 'admin');

-- CreateEnum
CREATE TYPE "StartupUserRole" AS ENUM ('owner');

-- CreateEnum
CREATE TYPE "StepType" AS ENUM ('check', 'upload');

-- CreateEnum
CREATE TYPE "StepStatus" AS ENUM ('open', 'in_progress', 'done');

-- CreateEnum
CREATE TYPE "SubscriptionPlan" AS ENUM ('freemium', 'premium');

-- CreateEnum
CREATE TYPE "SubscriptionStatus" AS ENUM ('active', 'canceled', 'past_due');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('succeeded', 'failed', 'pending');

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "email_verified" TIMESTAMP(3),
    "image" TEXT,
    "username" TEXT,
    "account_type" "AccountType" NOT NULL DEFAULT 'freemium',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "accounts" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "provider_account_id" TEXT NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,

    CONSTRAINT "accounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sessions" (
    "id" TEXT NOT NULL,
    "session_token" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "verification_tokens" (
    "identifier" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL
);

-- CreateTable
CREATE TABLE "startup_users" (
    "id" SERIAL NOT NULL,
    "startup_id" INTEGER NOT NULL,
    "user_id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "role" "StartupUserRole" NOT NULL DEFAULT 'owner',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "startup_users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "startups" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "current_level_id" INTEGER NOT NULL DEFAULT 1,
    "current_experience" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "startups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prompts" (
    "id" SERIAL NOT NULL,
    "startup_id" INTEGER NOT NULL,
    "user_id" TEXT NOT NULL,
    "prompt" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "prompts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "levels" (
    "id" SERIAL NOT NULL,
    "level_number" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "experience_needed" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "levels_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "steps" (
    "id" SERIAL NOT NULL,
    "startup_id" INTEGER NOT NULL,
    "level_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "explanation" TEXT NOT NULL,
    "type" "StepType" NOT NULL,
    "status" "StepStatus" NOT NULL DEFAULT 'open',
    "completed_by_user_id" TEXT,
    "completed_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "steps_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "subscriptions" (
    "id" SERIAL NOT NULL,
    "user_id" TEXT NOT NULL,
    "plan" "SubscriptionPlan" NOT NULL,
    "status" "SubscriptionStatus" NOT NULL,
    "start_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "end_date" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "subscriptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payments" (
    "id" SERIAL NOT NULL,
    "subscription_id" INTEGER NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "status" "PaymentStatus" NOT NULL,
    "payment_method" TEXT,
    "transaction_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "payments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "accounts_provider_provider_account_id_key" ON "accounts"("provider", "provider_account_id");

-- CreateIndex
CREATE UNIQUE INDEX "sessions_session_token_key" ON "sessions"("session_token");

-- CreateIndex
CREATE UNIQUE INDEX "verification_tokens_token_key" ON "verification_tokens"("token");

-- CreateIndex
CREATE UNIQUE INDEX "verification_tokens_identifier_token_key" ON "verification_tokens"("identifier", "token");

-- AddForeignKey
ALTER TABLE "accounts" ADD CONSTRAINT "accounts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "startup_users" ADD CONSTRAINT "startup_users_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "startup_users" ADD CONSTRAINT "startup_users_startup_id_fkey" FOREIGN KEY ("startup_id") REFERENCES "startups"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prompts" ADD CONSTRAINT "prompts_startup_id_fkey" FOREIGN KEY ("startup_id") REFERENCES "startups"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prompts" ADD CONSTRAINT "prompts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "steps" ADD CONSTRAINT "steps_startup_id_fkey" FOREIGN KEY ("startup_id") REFERENCES "startups"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "steps" ADD CONSTRAINT "steps_level_id_fkey" FOREIGN KEY ("level_id") REFERENCES "levels"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "steps" ADD CONSTRAINT "steps_completed_by_user_id_fkey" FOREIGN KEY ("completed_by_user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_subscription_id_fkey" FOREIGN KEY ("subscription_id") REFERENCES "subscriptions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
