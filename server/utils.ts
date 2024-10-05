import { dirname } from "path";
import { IDocument } from "../common/document";

export function generateTreeView(flatDocuments: IDocument[]) {
    let documents : IDocument[] = [];

    flatDocuments.forEach(d => {
        const docPath = d.relativePath.replace(/\\/g, "/");
        const dirName = dirname(docPath);
        if (dirName === "/") { documents.push(d); }
        else {
            const parent = flatDocuments.find(d => d.relativePath.replace(/\\/g, "/") === dirName );
            if (!!parent) {
                parent.subDocuments.push(d);
            } else {
                console.error("Impossible to find the parent: " + dirName)
            }
        }
    })
    return documents;
}

export function sortTreeDocuments(documents: IDocument[]) {
    const folders = documents.filter(d => d.type === "FOLDER");
    folders.forEach(f => { 
        const subDocs = sortTreeDocuments(f.subDocuments);
        f.subDocuments = subDocs;
    });
    const sortedDocuments = sortDocuments(documents);
    return sortedDocuments;
}

function sortDocuments(documents: IDocument[]) {
    return documents.sort((a, b) => {
        if (a.type === "FOLDER" && b.type === "FOLDER") {
            return a.name.localeCompare(b.name);
        } else if (a.type === "FOLDER") {
            return -1;
        } else if (b.type === "FOLDER") {
            return 1;
        } else {
            return a.name.localeCompare(b.name);
        }
    });
}