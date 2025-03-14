-- CreateTable
CREATE TABLE "Property" (
    "id" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "price" TEXT NOT NULL,
    "rooms" INTEGER NOT NULL,
    "wcs" INTEGER NOT NULL,
    "livingRooms" INTEGER NOT NULL,
    "Kitchens" INTEGER NOT NULL,
    "yards" INTEGER NOT NULL,
    "userId" TEXT,
    "locationId" TEXT,

    CONSTRAINT "Property_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Property" ADD CONSTRAINT "Property_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property" ADD CONSTRAINT "Property_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE SET NULL ON UPDATE CASCADE;
