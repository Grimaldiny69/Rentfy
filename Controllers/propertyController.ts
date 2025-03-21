import { PrismaClient, Property } from "@prisma/client";
class propertyController {
    private prisma: PrismaClient

    constructor() {
        this.prisma = new PrismaClient()
    }
    async createProperty(data: Omit<Property, "id">) {
        try {
            return this.prisma.property.create({
                data: {
                    ...data
                }
            })
        } catch (error) {
            return error
        }
    }
    async deleteProperty(id: string) {
        try {
            return this.prisma.property.delete({
                where: {
                    id: id
                }
            })
        } catch (error) {
            return error
        }
    }
}
module.exports = new propertyController