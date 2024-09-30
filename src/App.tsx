import { useEffect, useState } from 'react'
import './App.css'
import { Panel, PanelGroup, PanelResizeHandle } from 'react-resizable-panels'
import { DEFAULT_OPTIONS } from '../common/options'
import { FileExporerView } from './component/fileExplorer/view'
import { DEFAULT_WORKSPACE, IWorkspace } from '../common/workspace'
import { MarkdownView } from './component/markdown/view'
import { ServiceManager } from './business/serviceManager'
import { EventManager } from './business/eventManager'

const serviceManager = new ServiceManager();
const eventManager = new EventManager(serviceManager);

function App() {
  
  const [ options, setOptions ] = useState(DEFAULT_OPTIONS);
  const [ workspace, setWorkspace ] = useState(DEFAULT_WORKSPACE);
  eventManager.updateState(workspace, setWorkspace);
  

  useEffect(() => {

    // Load default workspace
    serviceManager.loadWorkspaceByName("default").then((workspace) => { setWorkspace(workspace); });

    // Init event manager
    eventManager.listen();
  }, [])

  return (
    <PanelGroup className='mainPanel' direction='vertical' onLayout={(layouts) => {}}>
      { !options.panels.top.disable && (
        <>
        <Panel className='panel' minSize={10} defaultSize={options.panels.top.size} maxSize={30}>Top</Panel>
        <PanelResizeHandle className='panelResize' />
        </>
      )}
      <Panel className='panel' defaultSize={100}>
        <PanelGroup direction='horizontal'>
          <Panel className='panel' defaultSize={options.panels.left.size} minSize={10} maxSize={20}>
            <FileExporerView workspace={workspace} />
          </Panel>
          <PanelResizeHandle className='panelResize' />
          <Panel className='panel'>
            { workspace.selectedDocument && (
                <MarkdownView document={workspace.selectedDocument} />
            )}
          </Panel>
          { !options.panels.right && (
          <>
          <PanelResizeHandle className='panelResize' />
          <Panel className='panel' defaultSize={options.panels.right.size} maxSize={5}>Right</Panel>
          </>
          )}
        </PanelGroup>
      </Panel>
      { !options.panels.bottom.disable && (
      <>
      <PanelResizeHandle className='panelResize' />
      <Panel className='panel' minSize={10} defaultSize={options.panels.bottom.size} maxSize={30}>Bottom</Panel>
      </>
      )}
    </PanelGroup>
  )
}

export default App
