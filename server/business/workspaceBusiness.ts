import { mkdir, readdir, readFile, stat, writeFile } from "fs/promises";
import { IWorkspace, MARKDOWN_EXAMPLE } from "../../common/workspace";
import { fastify } from "..";
import { IDocument } from "../../common/document";
import { basename, join } from "path";
import { homedir } from "os";
import { v4 } from "uuid";

const workspacesPath = join(homedir(), ".knownledga", "workspaces");;
const defaultWorkspacePath = join(homedir(), ".knownledga", "workspaces", "default");

export class WorkspaceBusiness {
    public static readWorkspaces() {
        return new Promise<IWorkspace[]>((resolve, reject) => {
            fastify.log.info("WorkspaceBusiness.readWorkspaces - Call method");
            readdir(workspacesPath, {withFileTypes: true}).then((files) => {
                const workspaces = files.filter(f => f.isDirectory()).map(f => {
                    return { path: f.name, documents: [] } as IWorkspace
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
            const path = join(workspacesPath, name);
            readdir(path, {withFileTypes: true, recursive: true}).then((files) => {
                const documents = files.map(f => {
                    return { id: v4(), name: f.name, path: join(f.parentPath, f.name), content: "" } as IDocument
                });
                const workspace : IWorkspace = {
                    id: v4(),
                    path: path,
                    documents: documents
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