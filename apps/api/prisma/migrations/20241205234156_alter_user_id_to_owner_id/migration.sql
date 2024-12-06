/*
  Warnings:

  - You are about to drop the column `user_id` on the `members` table. All the data in the column will be lost.
  - You are about to drop the column `user_id` on the `organizations` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[organization_id,owner_id]` on the table `members` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `owner_id` to the `members` table without a default value. This is not possible if the table is not empty.
  - Added the required column `owner_id` to the `organizations` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "members" DROP CONSTRAINT "members_user_id_fkey";

-- DropForeignKey
ALTER TABLE "organizations" DROP CONSTRAINT "organizations_user_id_fkey";

-- DropIndex
DROP INDEX "members_organization_id_user_id_key";

-- AlterTable
ALTER TABLE "members" DROP COLUMN "user_id",
ADD COLUMN     "owner_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "organizations" DROP COLUMN "user_id",
ADD COLUMN     "owner_id" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "members_organization_id_owner_id_key" ON "members"("organization_id", "owner_id");

-- AddForeignKey
ALTER TABLE "members" ADD CONSTRAINT "members_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "organizations" ADD CONSTRAINT "organizations_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
