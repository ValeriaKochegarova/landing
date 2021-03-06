import {Application} from 'express';
import {aboutUsCtrl} from './about-us.controller';
import { cloudDevelopmentCtrl } from './cloud_development.controller';
import { mailerCtrl } from './mailer.controller';
import {mainCtrl} from './main.controller';
import {mobileDevelopmentCtrl} from './mobile-development.controller';
import { webDevelopmentCtrl } from './web-development.controller';

export const controllers: (app: Application) => void = (app: Application) => {
    mainCtrl(app);
    aboutUsCtrl(app);
    webDevelopmentCtrl(app);
    mobileDevelopmentCtrl(app);
    cloudDevelopmentCtrl(app);
    mailerCtrl(app);
};
