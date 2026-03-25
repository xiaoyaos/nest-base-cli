import { IRespMsg, RespCodes } from 'nest-base';

export const CustomExceptionMap: Record<string, IRespMsg> = {
  TerminalUnAuth: { msg: '终端未授权.', code: 91001 },
};

export function CustomExceptionExtend(): void {
  RespCodes.CustomException = CustomExceptionMap;
}
