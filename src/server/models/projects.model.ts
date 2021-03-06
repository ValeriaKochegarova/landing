import * as mongoose from 'mongoose';

export class ProjectsNewModel {
    public async getContent(query: any = {}): Promise<any> {
        const projectsModel: mongoose.Model<mongoose.Document> = mongoose.model('Projects');
        return await projectsModel.findOne({...query})
        .lean();
    }
}
