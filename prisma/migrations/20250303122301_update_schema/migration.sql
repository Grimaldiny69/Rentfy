/*
  Warnings:

  - The values [admin] on the enum `UserType` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `images` on the `Images` table. All the data in the column will be lost.
  - You are about to drop the column `idHouse` on the `Location` table. All the data in the column will be lost.
  - You are about to drop the column `Kitchens` on the `Property` table. All the data in the column will be lost.
  - You are about to drop the column `commentsId` on the `Property` table. All the data in the column will be lost.
  - You are about to drop the column `imagesId` on the `Property` table. All the data in the column will be lost.
  - You are about to drop the column `client` on the `Rent` table. All the data in the column will be lost.
  - You are about to drop the column `IdNumber` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `commentsId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `propertyId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `rentId` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[propertyId]` on the table `Location` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `propertyId` to the `Comments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `Comments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `propertyId` to the `Images` table without a default value. This is not possible if the table is not empty.
  - Added the required column `url` to the `Images` table without a default value. This is not possible if the table is not empty.
  - Added the required column `kitchens` to the `Property` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ownerId` to the `Property` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `price` on the `Property` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `clientId` to the `Rent` table without a default value. This is not possible if the table is not empty.
  - Made the column `propertyId` on table `Rent` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `idNumber` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "UserType_new" AS ENUM ('Client', 'Owner', 'Admin');
ALTER TABLE "User" ALTER COLUMN "userType" TYPE "UserType_new" USING ("userType"::text::"UserType_new");
ALTER TYPE "UserType" RENAME TO "UserType_old";
ALTER TYPE "UserType_new" RENAME TO "UserType";
DROP TYPE "UserType_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "Property" DROP CONSTRAINT "Property_commentsId_fkey";

-- DropForeignKey
ALTER TABLE "Property" DROP CONSTRAINT "Property_imagesId_fkey";

-- DropForeignKey
ALTER TABLE "Rent" DROP CONSTRAINT "Rent_propertyId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_commentsId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_propertyId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_rentId_fkey";

-- AlterTable
ALTER TABLE "Comments" ADD COLUMN     "propertyId" TEXT NOT NULL,
ADD COLUMN     "userId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Images" DROP COLUMN "images",
ADD COLUMN     "propertyId" TEXT NOT NULL,
ADD COLUMN     "url" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Location" DROP COLUMN "idHouse";

-- AlterTable
ALTER TABLE "Property" DROP COLUMN "Kitchens",
DROP COLUMN "commentsId",
DROP COLUMN "imagesId",
ADD COLUMN     "kitchens" INTEGER NOT NULL,
ADD COLUMN     "ownerId" TEXT NOT NULL,
DROP COLUMN "price",
ADD COLUMN     "price" DECIMAL(65,30) NOT NULL;

-- AlterTable
ALTER TABLE "Rent" DROP COLUMN "client",
ADD COLUMN     "clientId" TEXT NOT NULL,
ALTER COLUMN "dateStart" SET DATA TYPE TIMESTAMP(3),
ALTER COLUMN "dateEnd" SET DATA TYPE TIMESTAMP(3),
ALTER COLUMN "propertyId" SET NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "IdNumber",
DROP COLUMN "commentsId",
DROP COLUMN "propertyId",
DROP COLUMN "rentId",
ADD COLUMN     "idNumber" VARCHAR(16) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Location_propertyId_key" ON "Location"("propertyId");

-- AddForeignKey
ALTER TABLE "Property" ADD CONSTRAINT "Property_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rent" ADD CONSTRAINT "Rent_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rent" ADD CONSTRAINT "Rent_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comments" ADD CONSTRAINT "Comments_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comments" ADD CONSTRAINT "Comments_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Images" ADD CONSTRAINT "Images_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
