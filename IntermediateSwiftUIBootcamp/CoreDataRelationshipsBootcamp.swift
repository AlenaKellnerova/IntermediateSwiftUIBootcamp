//
//  CoreDataRelationshipsBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 09.04.2025.
//

import SwiftUI
import CoreData

// 3 Entities:
/*
 BusinessEntity
 DepartmentEntity
 EmployeeEntity
 */

class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Error loading CoreData \(error), \(error.userInfo)")
            }
        }
        context = container.viewContext
    }
    
    func saveData() {
        do {
            try context.save()
            print("Saved succesfully!")
        } catch {
            print("Error saving core data: \(error)")
        }
    }
}

class CoreDataRelationshipsViewModel: ObservableObject {
    
    let coreDataManager = CoreDataManager.instance
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        fetchBusinesses()
        fetchDepartments()
        fetchEmplyees()
    }
    
    func fetchBusinesses() {
        let request: NSFetchRequest<BusinessEntity> = BusinessEntity.fetchRequest()
        // SORT
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: false)
        request.sortDescriptors = [sort]
        // FILTER
//        let filter = NSPredicate(format: "name == %@", "Apple")
//        request.predicate = filter
        do {
            businesses = try coreDataManager.context.fetch(request)
        } catch {
            print("Error fetching businesses: \(error)")
        }
    }
    
    func fetchDepartments() {
        let request: NSFetchRequest<DepartmentEntity> = DepartmentEntity.fetchRequest()
        do {
            departments = try coreDataManager.context.fetch(request)
        } catch {
            print("Error fetching departments: \(error)")
        }
    }
    
    func fetchEmplyees() {
        let request: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()
        do {
            employees = try coreDataManager.context.fetch(request)
        } catch {
            print("Error fetching employees: \(error)")
        }
    }
    
    func fetchEmplyees(forBusiness business: BusinessEntity) {
        let request: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()
        // Filter
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        do {
            employees = try coreDataManager.context.fetch(request)
        } catch {
            print("Error fetching employees: \(error)")
        }
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: coreDataManager.context)
        newBusiness.name = "Instagram"
//        newBusiness.departments = [departments[3], departments[0]]
//        newBusiness.employees = [employees[4]]
        save()
        
        // Add existing departments to the new business
//        newBusiness.departments = []
        
        // Add existing employees to the new business
//        newBusiness.employees = []
        
        // Add new business to existing department
//        newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // Add new business to existing employee
//        newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: coreDataManager.context)
        newDepartment.name = "Marketing"
        newDepartment.businesses = [businesses[0], businesses[18], businesses[19]]
        
//        newDepartment.employees = [employees[5]]
        newDepartment.addToEmployees(employees[4])
        
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: coreDataManager.context)
        newEmployee.name = "John"
        newEmployee.dateJoined = Date()
        newEmployee.business = businesses[4]
        newEmployee.department = departments[3]
        
        save()
    }
    
    func updateBusiness() {
        if let firstBusiness = businesses.first {
            firstBusiness.name = "Apple Inc."
            save()
        }
    }
    
    func deleteDepartment() {
        let departmetToDelete = departments[4]
        coreDataManager.context.delete(departmetToDelete)
        save()
    }
    
    func save () {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.coreDataManager.saveData()
            self.fetchBusinesses()
            self.fetchDepartments()
            self.fetchEmplyees()
        }
    }
    
    
    
}

struct CoreDataRelationshipsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Button {
//                        vm.addBusiness()
//                        vm.addDepartment()
//                        vm.addEmployee()
//                        vm.updateBusiness()
//                        vm.fetchEmplyees(forBusiness: vm.businesses[1])
                        vm.deleteDepartment()
                    } label: {
                        Text("Add business")
                            .foregroundStyle(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                            .padding()
                    }
                    // Businesses
                    ScrollView(.horizontal) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    // Departments
                    ScrollView(.horizontal) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)                            }
                        }
                    }
                    
                    // Employees
                    ScrollView(.horizontal) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }
                }
                .navigationTitle("Relationships")
            }
        }
    }
}

#Preview {
    CoreDataRelationshipsBootcamp()
}

struct BusinessView: View {
    
    let entity: BusinessEntity
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            // Departments
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments: ")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            // Employees
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees: ")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DepartmentView: View {
    
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            // Businesses
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses: ")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            
            // Employees
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees: ")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.pink.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
struct EmployeeView: View {
    
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            Text("Age: \(entity.age)")
            Text("Date joined: \(entity.dateJoined ?? Date())")
            
            // Businesses
            Text("Businesses: ")
                .bold()
            
            Text(entity.business?.name ?? "")
            
            // Department
            Text("Department: ")
                .bold()
            
            Text(entity.department?.name ?? "")
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.blue.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
