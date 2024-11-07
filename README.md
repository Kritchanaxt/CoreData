# Core Data

- Core Data เป็น **framework ของ Apple** ที่ใช้ในการจัดการโมเดลข้อมูล (data modeling) และ object graph บนระบบปฏิบัติการ iOS, macOS, tvOS และ watchOS เหมาะสำหรับแอปพลิเคชันที่มีการจัดการข้อมูลซับซ้อนและต้องการฟีเจอร์ขั้นสูง 

## 1. โครงสร้างและแนวคิดพื้นฐาน
- **Core Data**:
  - เป็น framework ที่ออกแบบมาเพื่อการจัดการข้อมูลในรูปแบบ **object-oriented** โดยใช้ **object graph management** สำหรับการจัดการความสัมพันธ์ระหว่างข้อมูล
  - สามารถใช้งานฟีเจอร์ต่าง ๆ ที่ซับซ้อน เช่น **lazy loading** (การโหลดข้อมูลเมื่อจำเป็นเท่านั้น), **validation** (การตรวจสอบข้อมูลก่อนบันทึก), และ **undo/redo** (การย้อนกลับหรือทำซ้ำการแก้ไข)
  - Core Data ใช้ **SQLite** เป็นหนึ่งในตัวเลือกของการเก็บข้อมูล (storage) แต่ไม่ได้ถูกออกแบบมาให้เป็นฐานข้อมูลโดยตรง การใช้งาน Core Data จึงแตกต่างจากการใช้ SQLite โดยตรง

## 2. ความเร็วและประสิทธิภาพ
- **Core Data**:
  - มีประสิทธิภาพสูงและสามารถปรับแต่งการทำงานให้เหมาะสมกับความต้องการของแอปพลิเคชันที่ซับซ้อน 
  - สามารถทำงานได้ทั้งแบบ synchronous และ asynchronous แต่การดึงข้อมูลแบบ synchronous อาจทำให้แอปทำงานช้าลงได้ หากมีข้อมูลจำนวนมากหรือการประมวลผลที่ซับซ้อน
  - Core Data ช่วยลดปัญหาเรื่องการล็อกข้อมูลขณะดึงข้อมูล ทำให้สามารถเข้าถึงข้อมูลได้อย่างรวดเร็ว

## 3. การติดตั้งและการใช้งาน
- **Core Data**:
  - เป็น framework ที่มาพร้อมกับ iOS และ macOS ดังนั้นไม่จำเป็นต้องติดตั้งเพิ่ม
  - การตั้งค่าการใช้งานเริ่มต้นอาจมีความซับซ้อน เนื่องจากต้องสร้างและกำหนดค่า `PersistentContainer` ซึ่งเป็นตัวจัดการข้อมูลถาวร และต้องมีการจัดการ `context` สำหรับการบันทึกและเรียกใช้ข้อมูล
  - ต้องสร้าง `entity` และกำหนด `attributes` ที่จำเป็นภายใน Xcode ซึ่งช่วยให้การทำงานเป็นไปตามโครงสร้างที่กำหนด

## 4. การซิงค์และการทำงานข้ามแพลตฟอร์ม
- **Core Data**:
  - รองรับการใช้งานบนหลายแพลตฟอร์มของ Apple เช่น iOS, macOS, tvOS, และ watchOS แต่ไม่มีการซิงค์ข้อมูลระหว่างอุปกรณ์โดยตรง
  - สามารถใช้ร่วมกับ **CloudKit** สำหรับการซิงค์ข้อมูลระหว่างอุปกรณ์ผ่าน iCloud แต่การตั้งค่าและการใช้งานค่อนข้างซับซ้อน และมีข้อจำกัดในด้านการควบคุมและความยืดหยุ่นเมื่อเปรียบเทียบกับการซิงค์ข้อมูลแบบอื่น ๆ เช่น Realm Sync

## 5. การออกแบบ Schema และการอัปเดตโครงสร้างฐานข้อมูล
- **Core Data**:
  - ต้องกำหนด **schema** ล่วงหน้า โดยการสร้าง `entity` และกำหนด `attributes` ที่ต้องการใน Xcode
  - เมื่อมีการเปลี่ยนแปลงโครงสร้างของฐานข้อมูล (เช่น การเพิ่มหรือลบ attributes) จำเป็นต้องทำ **migration** เพื่อให้ Core Data จัดการข้อมูลได้ตามโครงสร้างใหม่
  - Core Data มีการจัดการ migration อัตโนมัติในระดับเบื้องต้น แต่หากมีการเปลี่ยนแปลงโครงสร้างที่ซับซ้อนมากขึ้น นักพัฒนาจำเป็นต้องกำหนดการทำ migration เอง เพื่อหลีกเลี่ยงปัญหาข้อมูลสูญหาย

### ตัวอย่างโค้ดสำหรับการใช้งาน Core Data

```swift
import CoreData

// สร้าง context สำหรับการจัดการข้อมูลใน Core Data
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

// สร้าง entity ที่ชื่อว่า "User" ใน context
let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
let newUser = NSManagedObject(entity: entity!, insertInto: context)

// กำหนดค่า attributes ของ entity ที่สร้างขึ้น
newUser.setValue("John", forKey: "name")
newUser.setValue(30, forKey: "age")

// บันทึกข้อมูลลงใน Core Data
do {
    try context.save()
    print("Data saved successfully.")
} catch {
    print("Failed to save data: \(error)")
}
```

## สรุป
- **Core Data** เป็น framework ที่ทรงพลัง เหมาะกับการพัฒนาแอปพลิเคชันที่ต้องการจัดการ object graph ที่ซับซ้อนและฟีเจอร์ขั้นสูง เช่น lazy loading, validation, และ undo/redo
- เหมาะกับนักพัฒนาที่ต้องการควบคุมการทำงานของฐานข้อมูลในระดับลึก และสามารถจัดการ migration ของข้อมูลได้เมื่อมีการเปลี่ยนแปลง schema
- แม้ Core Data จะมาพร้อมกับระบบปฏิบัติการของ Apple และไม่ต้องติดตั้งเพิ่ม แต่การใช้งานอาจมีความซับซ้อนสำหรับนักพัฒนามือใหม่
