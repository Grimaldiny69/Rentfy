/*
  Warnings:

  - You are about to alter the column `name` on the `User` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.
  - You are about to alter the column `surname` on the `User` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.
  - You are about to alter the column `email` on the `User` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(50)`.
  - You are about to alter the column `IdNumber` on the `User` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(16)`.

*/
-- AlterTable
ALTER TABLE "User" ALTER COLUMN "name" SET DATA TYPE VARCHAR(100),
ALTER COLUMN "surname" SET DATA TYPE VARCHAR(100),
ALTER COLUMN "email" SET DATA TYPE VARCHAR(50),
ALTER COLUMN "phoneNumber" SET DATA TYPE VARCHAR(14),
ALTER COLUMN "IdNumber" SET DATA TYPE VARCHAR(16);

-- CreateTable
CREATE TABLE "Location" (
    "id" TEXT NOT NULL,
    "provincia" VARCHAR(50) NOT NULL,
    "municipio" VARCHAR(50) NOT NULL,
    "distrito" VARCHAR(100) NOT NULL,
    "bairro" VARCHAR(100) NOT NULL,
    "rua" VARCHAR(100) NOT NULL,
    "idHouse" INTEGER,

    CONSTRAINT "Location_pkey" PRIMARY KEY ("id")
);
