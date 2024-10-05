import { AppBar, Box, Button, IconButton, Input, TextField, Toolbar, Typography } from "@mui/material";
import FolderOpenIcon from '@mui/icons-material/FolderOpen';
import AddIcon from '@mui/icons-material/Add';
import ModeEditIcon from '@mui/icons-material/ModeEdit';
import DeleteIcon from '@mui/icons-material/Delete';
import { SimpleTreeView } from '@mui/x-tree-view/SimpleTreeView';
import { TreeItem } from "@mui/x-tree-view";
import { IWorkspace } from "../../../common/workspace.ts";
import { useState } from "react";
import { EventManager } from "../../business/eventManager.ts";

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
                        const needFocus = workspace.selectedDocument && d.path === workspace.selectedDocument.path;
                        return (
                            <TreeItem key={d.id} itemId={d.id} label={d.name} autoFocus={needFocus} onClick={(e) => { 
                                e.stopPropagation();
                                eventManager.selectDocument(d);
                            }} />
                        )
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