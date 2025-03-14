import { PrismaClient, Images } from "@prisma/client";
class imageController {
    private prisma: PrismaClient

    constructor() {
        this.prisma = new PrismaClient()
    }
    async createImages(data: Omit<Images, "id">) {
        try {
            return this.prisma.images.create({
                data: {
                    ...data
                }
            })
        } catch (error) {
            return error
        }
    }
}

module.exports = new imageController