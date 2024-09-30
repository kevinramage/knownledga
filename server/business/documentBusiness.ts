import { readFile } from "fs/promises";
import { fastify } from "..";
import { IDocument } from "../../common/document";
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
}