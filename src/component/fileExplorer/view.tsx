import { AppBar, Box, Button, IconButton, Input, TextField, Toolbar, Typography } from "@mui/material";
import FolderOpenIcon from '@mui/icons-material/FolderOpen';
import AddIcon from '@mui/icons-material/Add';
import ModeEditIcon from '@mui/icons-material/ModeEdit';
import DeleteIcon from '@mui/icons-material/Delete';
import { SimpleTreeView } from '@mui/x-tree-view/SimpleTreeView';
import { IWorkspace } from "../../../common/workspace.ts";
import { useState } from "react";
import { EventManager } from "../../business/eventManager.ts";
import { CustomTreeItem } from "../utils/customTreeItem.tsx";
import SegmentIcon from '@mui/icons-material/Segment';
import FolderIcon from '@mui/icons-material/Folder';
import DeviceUnknownIcon from '@mui/icons-material/DeviceUnknown';
import { IDocument } from "../../../common/document.ts";

export interface IFileExplorerViewProps {
    workspace: IWorkspace
    eventManager: EventManager
}

export function FileExporerView(props: IFileExplorerViewProps) {
    const { workspace, eventManager } = props;
    const [ newFileName, setNewFileName ] = useState(undefined as string | undefined);
    const deleteFile = (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
        eventManager.deleteFile(workspace.selectedDocument?.path as string);
        e.stopPropagation();
    }
    return (
        <Box className="fileExplorerView">
            <AppBar position="relative">
                <Toolbar>
                    <IconButton>
                        <FolderOpenIcon htmlColor="#F8D775" />
                    </IconButton>
                    <Typography>File explorer</Typography>
                    <div className="fileExplorerButtons">
                    <IconButton onClick={() => setNewFileName("newFile")}>
                        <AddIcon htmlColor="white" />
                    </IconButton>
                    <IconButton disabled={!workspace.selectedDocument}>
                        <ModeEditIcon htmlColor="white" />
                    </IconButton>
                    <IconButton disabled={!workspace.selectedDocument} onClick={deleteFile}>
                        <DeleteIcon htmlColor="white" />
                    </IconButton>
                    </div>
                </Toolbar>
                <SimpleTreeView>
                    { workspace && workspace.documents.map(d => {
                        return renderElement(d, workspace, eventManager);
                    })}
                    { newFileName !== undefined && (
                        <TextField className="newFileName" value={newFileName} onChange={(e) => setNewFileName(e.target.value)} onBlur={(e) => {
                            eventManager.addFile(workspace.path + "\\" + newFileName).then(() => {
                                setNewFileName(undefined);
                            })
                        }} onKeyUp={(e) => { 
                            if (e.code === "Enter") {
                                const input = e.target as HTMLInputElement;
                                input.blur();
                            }
                        }} />
                    )}                    
                </SimpleTreeView>
            </AppBar>
        </Box>
    )
}

function renderElement(d: IDocument,workspace: IWorkspace, eventManager: EventManager) {
    if (d.type === "FOLDER") {
        return renderFolder(d, workspace, eventManager);
    } else {
        return renderDocument(d, workspace, eventManager);
    }
}

function renderDocument(d: IDocument,workspace: IWorkspace, eventManager: EventManager) {
    const needFocus = workspace.selectedDocument && d.path === workspace.selectedDocument.path;
    const labelIcon = d.type === "MARKDOWN" ? SegmentIcon : SegmentIcon;
    return (
        <CustomTreeItem key={d.id} className="treeViewItem" itemId={d.id} label={d.name} labelIcon={labelIcon} autoFocus={needFocus} onClick={(e) => { 
            e.stopPropagation();
            eventManager.selectDocument(d);
        }} />
    )
}

function renderFolder(d: IDocument,workspace: IWorkspace, eventManager: EventManager) {
    return (
        <CustomTreeItem key={d.id} className="treeViewItem" itemId={d.id} label={d.name} labelIcon={FolderIcon}>
            { d.subDocuments.map(sd => renderElement(sd, workspace, eventManager))}
        </CustomTreeItem>
    )
}