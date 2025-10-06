/*
  Warnings:

  - You are about to drop the `accounts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `sessions` table. If the table is not empty, all the data it contains will be lost.
  - Made the column `email` on table `users` required. This step will fail if there are existing NULL values in that column.
  - The required column `id` was added to the `verification_tokens` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- DropForeignKey
ALTER TABLE "public"."accounts" DROP CONSTRAINT "accounts_user_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."sessions" DROP CONSTRAINT "sessions_user_id_fkey";

-- AlterTable
ALTER TABLE "users" ALTER COLUMN "email" SET NOT NULL;

-- AlterTable
ALTER TABLE "verification_tokens" ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "id" TEXT NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3),
ADD CONSTRAINT "verification_tokens_pkey" PRIMARY KEY ("id");

-- DropTable
DROP TABLE "public"."accounts";

-- DropTable
DROP TABLE "public"."sessions";
