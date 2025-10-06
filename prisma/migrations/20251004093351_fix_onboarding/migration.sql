/*
  Warnings:

  - The values [NOT_STARTED] on the enum `OnboardingStep` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "OnboardingStep_new" AS ENUM ('USER_PROFILE', 'STARTUP_INFO', 'FIRST_PROMPT', 'COMPLETED');
ALTER TABLE "public"."users" ALTER COLUMN "onboarding_step" DROP DEFAULT;
ALTER TABLE "users" ALTER COLUMN "onboarding_step" TYPE "OnboardingStep_new" USING ("onboarding_step"::text::"OnboardingStep_new");
ALTER TYPE "OnboardingStep" RENAME TO "OnboardingStep_old";
ALTER TYPE "OnboardingStep_new" RENAME TO "OnboardingStep";
DROP TYPE "public"."OnboardingStep_old";
ALTER TABLE "users" ALTER COLUMN "onboarding_step" SET DEFAULT 'USER_PROFILE';
COMMIT;

-- AlterTable
ALTER TABLE "users" ALTER COLUMN "onboarding_step" SET DEFAULT 'USER_PROFILE';
