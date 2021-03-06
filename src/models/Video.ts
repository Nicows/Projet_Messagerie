import Asset from './Asset';
import { IVideo } from '../interface/IVideo';
import MySQL from '../db/MySQL';
export default class Video extends Asset {

    private asset_idasset:number;

    constructor(id_video:number){
        super(id_video);
        this.asset_idasset=id_video;
    }
    save(): Promise < number > {
        return new Promise((resolve, reject) => {
            MySQL.insert('video', this).then((id: number) => {
                this.asset_idasset = id;
                resolve(id)
            })
        })
    }
    get attributInsert(): Array<string> {
        return ['asset_idasset'];
    }
    static update(update: Object, where: Object) {
        return new Promise((resolve, reject) => {
            MySQL.update('video', update, where).then((modifiedRows: number ) => {                    
                    console.log("Update Video(s) : "+modifiedRows);
                    resolve(modifiedRows);
                })
                .catch((err) => {
                    console.log(err);
                    reject(false)
                });
        })
    }
    static delete(where: Object) {
        return new Promise((resolve, reject) => {
            MySQL.delete('video', where).then((deletedRows: number ) => {                    
                    console.log("Deleted video(s) : "+deletedRows);
                    resolve(deletedRows);
                })
                .catch((err) => {
                    console.log(err);
                    reject(false)
                });
        })
    }
    static select(where: Object) {
        return new Promise((resolve, reject) => {
            MySQL.select('image', where).then((arrayUser: Array < Video > ) => {
                    let newVideo : Video;
                    let data: Array < Video > = [];
                    for (const video of arrayUser) {
                        if(video.asset_idasset === undefined ) video.asset_idasset;
                        newVideo= new Video(video.asset_idasset);
                        data.push(newVideo);
                    }
                    console.log(data);
                    resolve(data);
                })
                .catch((err) => {
                    console.log(err);
                    reject(false)
                });
        })
    }
}