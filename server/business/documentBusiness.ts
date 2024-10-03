import { readFile, rename, unlink, writeFile } from "fs/promises";
import { fastify } from "../index.ts";
import { IDocument } from "../../common/document.ts";
import { basename } from "path";
import { v4 } from "uuid";

export class DocumentBusiness {
    public static readDocument(path: string) {
        return new Promise<IDocument>((resolve, reject) => {
            fastify.log.info("DocumentBusiness.readDocument - Call method");
            ///TODO Normalize path
            readFile(path).then((file) => {
                const document : IDocument = {
                    id: v4(),
                    path: path,
                    name: basename(path),
                    content: file.toString()
                }
                resolve(document);
            }).catch((err) => {
                fastify.log.error("DocumentBusiness.readDocument - An error occured: ", err);
                reject(err);
            });
        });
    }
    public static addNewFile(path: string) {
        return new Promise<IDocument>((resolve, reject) => {
            fastify.log.info("DocumentBusiness.addNewFile - Call method");
            writeFile(path, "").then(() => {
                const document : IDocument = {
                    id: v4(),
                    path: path,
                    name: basename(path),
                    content: ""
                }
                resolve(document);
            }).catch((err) => {
                fastify.log.error("DocumentBusiness.addNewFile - An error occured: ", err);
                reject(err);
            })
        });
    }
    public static updateFile(id: string, path: string, content: string) {
        return new Promise<IDocument>((resolve, reject) => {
            fastify.log.info("DocumentBusiness.updateFile - Call method");
            writeFile(path, content).then(() => {
                const document : IDocument = {
                    id: id,
                    path: path,
                    name: basename(path),
                    content: content
                }
                resolve(document);
            }).catch((err) => {
                fastify.log.error("DocumentBusiness.updateFile - An error occured: ", err);
                reject(err);
            })
        });
    }
    public static deleteFile(path: string) {
        return new Promise<void>((resolve, reject) => {
            fastify.log.info("DocumentBusiness.deleteFile - Call method");
            unlink(path).then(() => {
                resolve();
            }).catch((err) => {
                fastify.log.error("DocumentBusiness.deleteFile - An error occured: ", err);
                reject(err);
            })
        });
    }
    public static renameFile(oldPath: string, newPath: string) {
        return new Promise<void>((resolve, reject) => {
            fastify.log.info("DocumentBusiness.renameFile - Call method");
            rename(oldPath, newPath).then(() => {
                resolve();
            }).catch((err) => {
                fastify.log.error("DocumentBusiness.renameFile - An error occured: ", err);
                reject(err);
            })
        });
    }
}