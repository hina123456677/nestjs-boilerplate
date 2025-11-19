import { Logger } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const port = process.env.PORT ?? 8000;

  // Listen on all network interfaces, not just localhost
  await app.listen(port, '0.0.0.0');

  Logger.log(`Server is running on port ${port}`);
}
bootstrap();
