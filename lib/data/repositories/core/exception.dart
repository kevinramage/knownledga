class KnowledgaException {
  final String code;
  final String message;

  KnowledgaException({required this.code, required this.message});
}

// DIR
const codeProjectDirExisted = "PJ_DIR_EXISTED";
const codeProjectCreateTechnical = "PJ_DIR_CREATE_TECHNICAL";
const codeProjectDirReadTechnical = "PJ_DIR_READ_TECHNICAL";
const codeProjectGitCloneTechnical = "PJ_DIR_GIT_CLONE_TECHNICAL";
const codeProjectGitAddTechnical = "PJ_DIR_GIT_ADD_TECHNICAL";
const codeProjectGitCommitTechnical = "PJ_DIR_GIT_COMMIT_TECHNICAL";
const codeProjectGitPushTechnical = "PJ_DIR_GIT_CPUSH_TECHNICAL";

// FILE
const codeFileCreateTechnical = "PJ_FILE_CREATE_TECHNICAL";
const codeFileDeleteTechnical = "PJ_FILE_DELETE_TECHNICAL";
const codeFileReadTechnical = "PJ_FILE_READ_TECHNICAL";
const codeFileWriteTechnical = "PJ_FILE_WRITE_TECHNICAL";
const codeFileRenameTechnical = "PJ_FILE_RENAME_TECHNICAL";