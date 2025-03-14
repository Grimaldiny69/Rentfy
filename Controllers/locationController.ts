import { PrismaClient, Location } from "@prisma/client";
class locationController {
    private prisma: PrismaClient

    constructor() {
        this.prisma = new PrismaClient()
    }
    async createLocation(data: Omit<Location, "id">) {
        try {
            return this.prisma.location.create({
                data: {
                    ...data
                }
            })
        } catch (error) {
            return error
        }
    }
}
module.exports = new locationController