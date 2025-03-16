import { PrismaClient, User } from "@prisma/client";

class userController {
    private prisma: PrismaClient;

    constructor() {
        this.prisma = new PrismaClient()
    }

    async create(data: Omit<User, "id">) {
        try {
            return this.prisma.user.create({
                data: {
                    ...data
                }
            })
        } catch (error) {
            return error
        }
    }
    async deleteUser(id: string) {
        try {
            return this.prisma.user.delete({
                where: {
                    id: id
                }
            })
        } catch (error) {
            return error
        }
    }
}

module.exports = new userController