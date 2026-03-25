import { Module } from '@nestjs/common';
import { AutoConfiguredModule, NestCommonModule } from 'nest-base';
import { AppController } from './app.controller';
import { AppService } from './app.service';

@Module({
  imports: [NestCommonModule.forRoot()],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule extends AutoConfiguredModule {}
