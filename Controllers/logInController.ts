import { PrismaClient } from "@prisma/client";
class logInController{
    private prisma: PrismaClient;

    constructor() {
        this.prisma = new PrismaClient()
    }

    async findUser(email: string, password: string) {
        try {
            return this.prisma.user.findUnique({
                where: {
                    email: email,
                    password: password
                }
            })
        } catch (error) {
            return error
        }
    }
}

module.exports = new logInController