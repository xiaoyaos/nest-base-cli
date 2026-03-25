import 'reflect-metadata';

import { Logger } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { setupNestCommon } from 'nest-base';
import { AppModule } from './app.module';
import { ConfigService } from '@nestjs/config';
import { CustomExceptionExtend } from './utils/CustomExceptionExtend';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    bufferLogs: true,
  });

  const configService = app.get(ConfigService);
  const port = configService.get<number>('app.port', 3000);

  setupNestCommon(app);
  CustomExceptionExtend();

  await app.listen(port, '0.0.0.0');

  Logger.log(`Application is running on: ${await app.getUrl()}`);
}
bootstrap();
