import { IDocument } from "./document.ts";

export interface IWorkspace {
    id: string;
    path: string;
    documents: IDocument[];
    selectedDocument ?: IDocument
}

export const MARKDOWN_EXAMPLE = `
# Title 1
## Title 2
### Title 3
#### Title 4
##### Title 5
###### Title 6

* Unordered elt 1
* Unordered elt 2

1. Unordered elt 1
2. Unordered elt 2

~~~
{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25
}
~~~
| Syntax | Description |
| --- | ----------- |
| Header | Title |
| Paragraph | Text |

- [x] Write the press release
- [ ] Update the website
- [ ] Contact the media

> Dorothy followed her through many of the beautiful rooms in her castle.

My favorite search engine is [Duck Duck Go](https://duckduckgo.com).
I just love **bold text**.

This text is ***really important***.
`

export const DEFAULT_WORKSPACE : IWorkspace = {
    id: "1",
    path: "C:\\workspaces\\default",
    documents: []
}