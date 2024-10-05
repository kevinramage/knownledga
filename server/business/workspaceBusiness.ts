import { mkdir, readdir, readFile, stat, writeFile } from "fs/promises";
import { IWorkspace, MARKDOWN_EXAMPLE } from "../../common/workspace.ts";
import { fastify } from "../index.ts";
import { DOCUMENT_TYPE, IDocument } from "../../common/document.ts";
import path, { basename, join } from "path";
import { homedir } from "os";
import { v4 } from "uuid";
import { generateTreeView, sortTreeDocuments } from "../utils.ts";

const workspacesPath = join(homedir(), ".knownledga", "workspaces");;
const defaultWorkspacePath = join(homedir(), ".knownledga", "workspaces", "default");

export class WorkspaceBusiness {
    public static readWorkspaces() {
        return new Promise<IWorkspace[]>((resolve, reject) => {
            fastify.log.info("WorkspaceBusiness.readWorkspaces - Call method");
            readdir(workspacesPath, {withFileTypes: true}).then((files) => {
                const workspaces = files.filter(f => f.isDirectory()).map(f => {
                    return { id: v4(), path: f.name, documents: [] } as IWorkspace
                });
                resolve(workspaces);
            }).catch((err) => {
                fastify.log.error("WorkspaceBusiness.readWorkspaces - An error occured: ", err);
                reject(err);
            });
        });
    }
    public static readWorkspace(name: string) {
        return new Promise<IWorkspace>((resolve, reject) => {
            if (name === "default") {
                WorkspaceBusiness.checkDefaultWorkspace().then(() => {
                    WorkspaceBusiness._readWorkspace(name).then((w) => resolve(w)).catch((err) => reject(err));
                }).catch((err) => reject(err))
            } else {
                WorkspaceBusiness._readWorkspace(name).then((w) => resolve(w)).catch((err) => reject(err));
            }
        });
    }
    private static _readWorkspace(name: string) {
        return new Promise<IWorkspace>((resolve, reject) => {
            fastify.log.info("WorkspaceBusiness.readWorkspace - Call method");
            
            const workspacePath = join(workspacesPath, name);
            readdir(workspacePath, {withFileTypes: true, recursive: true}).then((files) => {
                const documents = files.map(f => {

                    // File type
                    let fileType : DOCUMENT_TYPE = "UNKNOWN";
                    if (f.isDirectory()) { fileType = "FOLDER" }
                    else if (path.extname(f.name).toLowerCase() === ".md") { fileType = "MARKDOWN" }

                    // Path
                    const filePath = join(f.parentPath, f.name);
                    const relativePath = filePath.substring(workspacePath.length);
                    
                    return { id: v4(), type: fileType, name: f.name, path: filePath, relativePath: relativePath, content: "", subDocuments: [] } as IDocument
                });
                const treeViewDocuments = generateTreeView(documents);
                const sortedDocuments = sortTreeDocuments(treeViewDocuments);
                const workspace : IWorkspace = {
                    id: v4(),
                    path: workspacePath,
                    documents: sortedDocuments
                }
                resolve(workspace);
            }).catch((err) => {
                fastify.log.error("WorkspaceBusiness.readWorkspace - An error occured: ", err);
                reject(err);
            });
        });
    }
    private static checkDefaultWorkspace() {
        return new Promise<void>((resolve, reject) => {
            fastify.log.info("WorkspaceBusiness.checkDefaultWorkspace - Call method");
            stat(defaultWorkspacePath).then((stat) => {
                resolve();
            }).catch((err) => {
                // Directory not exists
                if (err && err.errno === -4058) {
                    WorkspaceBusiness.instanciateDefaultWorkspace()
                        .then(() => { resolve() })
                        .catch((err) => { reject(err); })
                } else {
                    reject(err);
                }
            })
        });
    }
    private static instanciateDefaultWorkspace() {
        fastify.log.info("WorkspaceBusiness.instanciateDefaultWorkspace - Call method");
        return Promise.all([
            mkdir(defaultWorkspacePath, {recursive: true}),
            writeFile(join(defaultWorkspacePath, "index.md"), ""),
            writeFile(join(defaultWorkspacePath, "example.md"), MARKDOWN_EXAMPLE)
        ]);
    }
}